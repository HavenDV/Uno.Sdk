#
# Copyright (c) Uno Platform Inc. All rights reserved.
# Licensed under the Apache-2.0 license. See LICENSE file in the project root for full license information.
#

#!/bin/bash -e

MANIFEST_NAME="H.Uno.Sdk.Manifest"
MANIFEST_VERSION="<latest>"
SOURCE="<auto>"
DOTNET_INSTALL_DIR="<auto>"
DOTNET_TARGET_VERSION_BAND="<auto>"
DOTNET_DEFAULT_PATH_LINUX="/usr/share/dotnet"
DOTNET_DEFAULT_PATH_MACOS="/usr/local/share/dotnet"
UPDATE_ALL_WORKLOADS="false"

while [ $# -ne 0 ]; do
    name=$1
    case "$name" in
        -v|--version)
            shift
            MANIFEST_VERSION=$1
            ;;
        -s|--source)
            shift
            SOURCE=$1
            ;;
        -d|--dotnet-install-dir)
            shift
            DOTNET_INSTALL_DIR=$1
            ;;
        -t|--dotnet-target-version-band)
            shift
            DOTNET_TARGET_VERSION_BAND=$1
            ;;
        -u|--update-all-workloads)
            shift
            UPDATE_ALL_WORKLOADS="true"
            ;;
        -h|--help)
            script_name="$(basename "$0")"
            echo "Uno Workload Installer"
            echo "Usage: $script_name [-v|--version <VERSION>] [-d|--dotnet-install-dir <DIR>] [-t|--dotnet-target-version-band <VERSION>]"
            echo "       $script_name -h|-?|--help"
            echo ""
            echo "Options:"
            echo "  -v,--version <VERSION>                     Use specific VERSION, Defaults to \`$MANIFEST_VERSION\`."
            echo "  -d,--dotnet-install-dir <DIR>              Dotnet SDK Location installed, Defaults to \`$DOTNET_INSTALL_DIR\`."
            echo "  -t,--dotnet-target-version-band <VERSION>  Use specific dotnet version band for install location, Defaults to \`$DOTNET_TARGET_VERSION_BAND\`."
            exit 0
            ;;
        *)
            echo "Unknown argument \`$name\`"
            exit 1
            ;;
    esac

    shift
done

function read_dotnet_link() {
    cd -P "$(dirname "$1")"
    dotnet_file="$PWD/$(basename "$1")"
    while [[ -h "$dotnet_file" ]]; do
        cd -P "$(dirname "$dotnet_file")"
        dotnet_file="$(readlink "$dotnet_file")"
        cd -P "$(dirname "$dotnet_file")"
        dotnet_file="$PWD/$(basename "$dotnet_file")"
    done
    echo $PWD
}

function error_permission_denied() {
    echo "No permission to install manifest. Try again with sudo."
    exit 1
}

function ensure_directory() {
    if [ ! -d $1 ]; then
        mkdir -p $1 || error_permission_denied
    fi
    [ ! -w $1 ] && error_permission_denied
}

# Check dotnet install directory.
if [[ "$DOTNET_INSTALL_DIR" == "<auto>" ]]; then
    if [[ -n "$DOTNET_ROOT" && -d "$DOTNET_ROOT" ]]; then
        DOTNET_INSTALL_DIR=$DOTNET_ROOT
    elif [[ -d "$DOTNET_DEFAULT_PATH_LINUX" ]]; then
        DOTNET_INSTALL_DIR=$DOTNET_DEFAULT_PATH_LINUX
    elif [[ -d "$DOTNET_DEFAULT_PATH_MACOS" ]]; then
        DOTNET_INSTALL_DIR=$DOTNET_DEFAULT_PATH_MACOS
    elif [[ -n "$(which dotnet)" ]]; then
        DOTNET_INSTALL_DIR=$(read_dotnet_link $(which dotnet))
    fi
fi
if [ ! -d $DOTNET_INSTALL_DIR ]; then
    echo "No installed dotnet \`$DOTNET_INSTALL_DIR\`."
    exit 1
fi

# Check installed dotnet version
DOTNET_COMMAND="$DOTNET_INSTALL_DIR/dotnet"

if [ ! -x "$DOTNET_COMMAND" ]; then
    echo "$DOTNET_COMMAND command not found"
    exit 1
fi

function install_uno_workload() {
    DOTNET_VERSION=$1
    SOURCE=$2
    IFS='.' read -r -a array <<< "$DOTNET_VERSION"
    CURRENT_DOTNET_VERSION=${array[0]}
    DOTNET_VERSION_BAND="${array[0]}.${array[1]}.${array[2]:0:1}00"

    # Reset local variables
    if [[ "$UPDATE_ALL_WORKLOADS" == "true" ]]; then
        DOTNET_TARGET_VERSION_BAND="<auto>"
        MANIFEST_VERSION="<latest>"
    fi

    # Check version band
    if [[ "$DOTNET_TARGET_VERSION_BAND" == "<auto>" ]]; then
        if [[ "$CURRENT_DOTNET_VERSION" -ge "7" ]]; then
            if [[ "$DOTNET_VERSION" == *"-preview"* || $DOTNET_VERSION == *"-rc"* || $DOTNET_VERSION == *"-alpha"* ]] && [[ ${#array[@]} -ge 4 ]]; then
                DOTNET_TARGET_VERSION_BAND="$DOTNET_VERSION_BAND${array[2]:3}.${array[3]}"
            else
                DOTNET_TARGET_VERSION_BAND=$DOTNET_VERSION_BAND
            fi
        else
            DOTNET_TARGET_VERSION_BAND=$DOTNET_VERSION_BAND
        fi
    fi

    # Check latest version of manifest.
    if [[ "$MANIFEST_VERSION" == "<latest>" ]]; then
        MANIFEST_VERSION="0.9.6"
        if [ ! "$MANIFEST_VERSION" ]; then
            MANIFEST_VERSION=$(curl -s https://api.nuget.org/v3-flatcontainer/$MANIFEST_NAME/index.json | grep \" | tail -n 1 | tr -d '\r' | xargs)
            if [[ -n $MANIFEST_VERSION ]]; then
                echo "Return cached latest version: $MANIFEST_VERSION"
            else
                echo "Failed to get the latest version of $MANIFEST_NAME."
                return
            fi
        fi
    fi

    # Check workload manifest directory.
    SDK_MANIFESTS_DIR=$DOTNET_INSTALL_DIR/sdk-manifests/$DOTNET_TARGET_VERSION_BAND
    ensure_directory $SDK_MANIFESTS_DIR

    TMPDIR=$(mktemp -d)

    echo "Installing $MANIFEST_NAME/$MANIFEST_VERSION to $SDK_MANIFESTS_DIR..."

    # Download and extract the manifest nuget package.
    if [[ "$SOURCE" == "<auto>" ]]; then
      curl -s -o $TMPDIR/manifest.zip -L https://www.nuget.org/api/v2/package/$MANIFEST_NAME/$MANIFEST_VERSION
    else
      cp -f $SOURCE/$MANIFEST_NAME.$MANIFEST_VERSION.nupkg $TMPDIR/manifest.zip
    fi

    unzip -qq -d $TMPDIR/unzipped $TMPDIR/manifest.zip
    if [ ! -d $TMPDIR/unzipped/data ]; then
        echo "No such files to install."
        return
    fi
    chmod 744 $TMPDIR/unzipped/data/*

    # Copy manifest files to dotnet sdk.
    mkdir -p $SDK_MANIFESTS_DIR/uno.sdk.manifest
    cp -f $TMPDIR/unzipped/data/* $SDK_MANIFESTS_DIR/uno.sdk.manifest/

    if [ ! -f $SDK_MANIFESTS_DIR/uno.sdk.manifest/WorkloadManifest.json ]; then
        echo "Installation is failed."
        return
    fi

    # Install workload packs.
    if [ -f global.json ]; then
        CACHE_GLOBAL_JSON="true"
        mv global.json global.json.bak
    else
        CACHE_GLOBAL_JSON="false"
    fi
    dotnet new globaljson --sdk-version $DOTNET_VERSION
    
    if [[ "$SOURCE" == "<auto>" ]]; then
      $DOTNET_INSTALL_DIR/dotnet workload install uno --skip-manifest-update
    else
      $DOTNET_INSTALL_DIR/dotnet workload install uno --skip-manifest-update --source $SOURCE
    fi
    
    # Clean-up
    rm -fr $TMPDIR
    rm global.json
    if [[ "$CACHE_GLOBAL_JSON" == "true" ]]; then
        mv global.json.bak global.json
    fi

    echo "Done installing Uno workload $MANIFEST_VERSION"
    echo ""
}

if [[ "$UPDATE_ALL_WORKLOADS" == "true" ]]; then
    INSTALLED_DOTNET_SDKS=$($DOTNET_COMMAND --list-sdks | sed -n '/^6\|^7/p' | sed 's/ \[.*//g')
else
    INSTALLED_DOTNET_SDKS=$($DOTNET_COMMAND --version)
fi

if [ -z "$INSTALLED_DOTNET_SDKS" ]; then
    echo ".NET SDK version 6 or later is required to install Uno Workload."
else
    for DOTNET_SDK in $INSTALLED_DOTNET_SDKS; do
        echo "Check Uno Workload for sdk $DOTNET_SDK."
        install_uno_workload $DOTNET_SDK $SOURCE
    done
fi

echo "DONE"
