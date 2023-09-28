# Uno.Sdk

[![Nuget package](https://img.shields.io/nuget/vpre/H.Uno.Sdk)](https://www.nuget.org/packages/H.Uno.Sdk/)
[![dotnet](https://github.com/HavenDV/Uno.Sdk/actions/workflows/dotnet.yml/badge.svg?branch=main)](https://github.com/HavenDV/Uno.Sdk/actions/workflows/dotnet.yml)
[![License: MIT](https://img.shields.io/github/license/HavenDV/Uno.Sdk)](https://github.com/HavenDV/Uno.Sdk/blob/main/LICENSE.txt)
[![Discord](https://img.shields.io/discord/1115206893015662663?label=Discord&logo=discord&logoColor=white&color=d82679)](https://discord.gg/Ca2xhfBf3v)

Easy configuration for Uno projects in 2 lines of code.
Now is only there platforms are supported:
- Mobile
- Skia
- WebAssembly

### Usage
```xml
<Project Sdk="H.Uno.Sdk/0.6.0">

    <PropertyGroup>
        <TargetFramework>net7.0-maccatalyst;net7.0-android;net7.0-ios;net7.0-skia;net7.0-webassembly</TargetFramework>
        <!-- Still unsupported: ;net7.0-windows10.0.19041.0 -->
    </PropertyGroup>

</Project>
```

### Install
To support custom target frameworks, you need to install the appropriate workloads:
- On Linux / macOS:
```
curl -sSL https://raw.githubusercontent.com/HavenDV/Skia/main/scripts/workload-install.sh | sudo bash
curl -sSL https://raw.githubusercontent.com/HavenDV/WebAssembly/main/scripts/workload-install.sh | sudo bash
```
- On Windows:
```
Invoke-WebRequest 'https://raw.githubusercontent.com/HavenDV/Skia/main/workload/scripts/workload-install.ps1' -OutFile 'workload-install.ps1';
./workload-install.ps1
Invoke-WebRequest 'https://raw.githubusercontent.com/HavenDV/WebAssembly/main/workload/scripts/workload-install.ps1' -OutFile 'workload-install.ps1';
./workload-install.ps1
```

## Support

Priority place for bugs: https://github.com/HavenDV/Uno.Sdk/issues  
Priority place for ideas and general questions: https://github.com/HavenDV/Uno.Sdk/discussions  
Discord: https://discord.gg/g8u2t9dKgE  