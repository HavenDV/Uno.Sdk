# Uno.Sdk

[![Nuget package](https://img.shields.io/nuget/vpre/H.Uno.Sdk)](https://www.nuget.org/packages/H.Uno.Sdk/)
[![dotnet](https://github.com/HavenDV/Uno.Sdk/actions/workflows/dotnet.yml/badge.svg?branch=main)](https://github.com/HavenDV/Uno.Sdk/actions/workflows/dotnet.yml)
[![License: MIT](https://img.shields.io/github/license/HavenDV/Uno.Sdk)](https://github.com/HavenDV/Uno.Sdk/blob/main/LICENSE.txt)
[![Discord](https://img.shields.io/discord/1115206893015662663?label=Discord&logo=discord&logoColor=white&color=d82679)](https://discord.gg/Ca2xhfBf3v)

Single project solution for Uno.
Supported platforms:
- Mobile(macOS, MacCatalyst and Android)(`net7.0-maccatalyst;net7.0-android;net7.0-ios`)
- Windows(`net7.0-windows10.0.19041.0` or any other `net7.0-windows10`)
- WebAssembly(`net7.0-webassembly`)
- Skia.Gkt(`net7.0-gtk`)
- Skia.Wpf(`net7.0-windows`)(this is an implicit indication for `net7.0-windows7`)
- Skia.Linux.Framebuffer(`net7.0-linux`)
- Skia.Tizen(`net7.0-tizen`)(Untested)

### Usage
Here are three possible uses:
- Use local SDK after installing workload
```xml
<Project Sdk="H.Uno.Sdk">

    <PropertyGroup>
        <TargetFrameworks>net7.0-maccatalyst;net7.0-android;net7.0-ios;net7.0-webassembly;net7.0-gtk;net7.0-linux;net7.0-windows</TargetFrameworks>
        <TargetFrameworks Condition="$([MSBuild]::IsOSPlatform('windows'))">$(TargetFrameworks);net7.0-windows10.0.19041.0</TargetFrameworks>
    </PropertyGroup>

</Project>
```
- Use SDK via NuGet. A small hack will be used here to disable the error message about missing workloads for webassembly/linux/gtk.
```xml
<Project Sdk="H.Uno.Sdk/0.15.0">

    <PropertyGroup>
        <TargetFrameworks>net7.0-maccatalyst;net7.0-android;net7.0-ios;net7.0-webassembly;net7.0-gtk;net7.0-linux;net7.0-windows</TargetFrameworks>
        <TargetFrameworks Condition="$([MSBuild]::IsOSPlatform('windows'))">$(TargetFrameworks);net7.0-windows10.0.19041.0</TargetFrameworks>
    </PropertyGroup>

</Project>
```
Note: To restore correctly from NuGet you need to run this in a project where `net7.0-webassembly;net7.0-gtk;net7.0-linux` is missing
- Use via `Microsoft.NET.Sdk` and `<UseUno>true</UseUno>` after installing the workload 
(the most correct, but currently not supported due to the fact that WebAssembly requires Microsoft.NET.Sdk.Web 
which will not work with some target frameworks)
```xml
<Project Sdk="Microsoft.NET.Sdk">

    <PropertyGroup>
        <TargetFrameworks>net7.0-maccatalyst;net7.0-android;net7.0-ios;net7.0-webassembly;net7.0-gtk;net7.0-linux;net7.0-windows</TargetFrameworks>
        <TargetFrameworks Condition="$([MSBuild]::IsOSPlatform('windows'))">$(TargetFrameworks);net7.0-windows10.0.19041.0</TargetFrameworks>
        <UseUno>true</UseUno> <!-- or UseUnoUwp -->
    </PropertyGroup>

</Project>
```

### Fast start
You can use https://github.com/HavenDV/Uno.Sdk.Example/ as a start point or just use templates:
```shell
dotnet new install H.Uno.Templates # If you don't have installed workload
mkdir SingleProjectSolution
cd SingleProjectSolution
dotnet new uno
dotnet build
dotnet run --framework net7.0-gtk
```

### Install workload
Although you don't have to do this for NuGet way, full support for the custom target frameworks requires installing the appropriate workload:
- On Linux / macOS:
```
curl -sSL https://raw.githubusercontent.com/HavenDV/Uno.Sdk/main/scripts/workload-install.sh | sudo bash
```
- On Windows:
```
Invoke-WebRequest 'https://raw.githubusercontent.com/HavenDV/Uno.Sdk/main/scripts/workload-install.ps1' -OutFile 'workload-install.ps1';
./workload-install.ps1
```

### Uninstall
```
dotnet workload uninstall uno
```

### Settings
The SDK is designed to assign default values only to properties that have not been explicitly set by the user. 
This way the user has full control over what the SDK does. 
Settings:
- `<UseUnoUwp>true</UseUnoUwp>` - will use Uno.UI packages instead of Uno.WinUI.
- `<UnoVersion>5.0.0</UnoVersion` (and other versions, see [here](https://github.com/HavenDV/Uno.Sdk/blob/main/src/workload/Uno.Sdk/Sdk/BundledVersions.targets#L10)) - will change the versions of all implicit PackageReferences

### Disclaimer
Although this is a working solution, I have simplified some things regarding workload and manifest,
which could theoretically cause problems (for example, when upgrading to a new sdk version).  

### Docs
Official documentation regarding the design of Workloads and Sdks:
- https://github.com/dotnet/sdk/tree/main/documentation/general/workloads
- https://github.com/dotnet/designs/blob/main/accepted/2020/workloads/workloads.md
- https://github.com/dotnet/designs/blob/main/accepted/2020/workloads/workload-resolvers.md
- https://github.com/dotnet/designs/blob/main/accepted/2020/workloads/workload-manifest.md
- https://github.com/dotnet/designs/blob/main/accepted/2021/workloads/workload-installation.md
- MAUI Workload - https://github.com/dotnet/maui/tree/main/src/Workload
- Tizen Workload - https://github.com/Samsung/Tizen.NET/tree/main/workload
- Uno Single Project Targets - https://github.com/unoplatform/uno/blob/master/build/nuget/uno.winui.single-project.targets

## Support

Priority place for bugs: https://github.com/HavenDV/Uno.Sdk/issues  
Priority place for ideas and general questions: https://github.com/HavenDV/Uno.Sdk/discussions  
Discord: https://discord.gg/g8u2t9dKgE  