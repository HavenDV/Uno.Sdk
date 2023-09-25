# Uno.Sdk

[![Nuget package](https://img.shields.io/nuget/vpre/H.Uno.Sdk)](https://www.nuget.org/packages/H.Uno.Sdk/)
[![dotnet](https://github.com/HavenDV/Uno.Sdk/actions/workflows/dotnet.yml/badge.svg?branch=main)](https://github.com/HavenDV/Uno.Sdk/actions/workflows/dotnet.yml)
[![License: MIT](https://img.shields.io/github/license/HavenDV/Uno.Sdk)](https://github.com/HavenDV/Uno.Sdk/blob/main/LICENSE.txt)
[![Discord](https://img.shields.io/discord/1115206893015662663?label=Discord&logo=discord&logoColor=white&color=d82679)](https://discord.gg/Ca2xhfBf3v)

Easy configuration for Uno projects in 2 lines of code

### Usage
```xml
<Project Sdk="Microsoft.NET.Sdk">

    <PropertyGroup>
        <TargetFramework>net7.0-windows10.0.19041.0;net7.0-maccatalyst;net7.0-android;net7.0-ios;net7.0</TargetFramework>
        <!-- <UseUnoUwp>true</UseUnoUwp> -->
    </PropertyGroup>
    
    <ItemGroup>
        <PackageReference Include="H.Uno.Sdk" Version="4.9.45" />
    </ItemGroup>

</Project>
```

### Possible future of this package
One project with:
```xml
<Project Sdk="Uno.Sdk/5.0.0">

    <PropertyGroup>
        <TargetFrameworks>net7.0-maccatalyst;net7.0-android;net7.0-ios;net7.0-windows10.0.19041.0;net7.0-webassembly;net7.0-skia-gtk</TargetFrameworks>
    </PropertyGroup>

</Project>
```

## Support

Priority place for bugs: https://github.com/HavenDV/Uno.Sdk/issues  
Priority place for ideas and general questions: https://github.com/HavenDV/Uno.Sdk/discussions  
Discord: https://discord.gg/g8u2t9dKgE  