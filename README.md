# EasyUno

[![Nuget package](https://img.shields.io/nuget/vpre/EasyUno)](https://www.nuget.org/packages/EasyUno/)
[![dotnet](https://github.com/HavenDV/EasyUno/actions/workflows/dotnet.yml/badge.svg?branch=main)](https://github.com/HavenDV/EasyUno/actions/workflows/dotnet.yml)
[![License: MIT](https://img.shields.io/github/license/HavenDV/EasyUno)](https://github.com/HavenDV/EasyUno/blob/main/LICENSE.txt)
[![Discord](https://img.shields.io/discord/1115206893015662663?label=Discord&logo=discord&logoColor=white&color=d82679)](https://discord.gg/Ca2xhfBf3v)

Easy configuration for Uno projects in 2 lines of code

### Usage
```xml
<Project Sdk="Microsoft.NET.Sdk">

    <PropertyGroup>
        <TargetFramework>net7.0-windows10.0.19041.0;net7.0-maccatalyst;net7.0-android;net7.0-ios;net7.0</TargetFramework>
        <UseUnoWinUI>true</UseUnoWinUI>
    </PropertyGroup>
    
    <ItemGroup>
        <PackageReference Include="EasyUno" Version="4.9.45" />
    </ItemGroup>

</Project>
```

### Possible future of this package
One project with:
```xml
<Project Sdk="Uno.Sdk/4.9.45">
    
  <PropertyGroup>
    <TargetFrameworks>uno-maccatalyst;uno-android;uno-ios;uno-windows;uno-wasm;uno-skia-gtk</TargetFrameworks>
  </PropertyGroup>
    
</Project>
```
or:
```xml
<Project Sdk="Uno.Sdk/4.9.45">
    
  <PropertyGroup>
    <TargetFrameworks>net7.0-uno-maccatalyst;net7.0-uno-android;net7.0-uno-ios;net7.0-uno-windows10.0.19041.0;net7.0-uno-wasm;net7.0-uno-skia-gtk</TargetFrameworks>
  </PropertyGroup>
    
</Project>
```

## Support

Priority place for bugs: https://github.com/HavenDV/EasyUno/issues  
Priority place for ideas and general questions: https://github.com/HavenDV/EasyUno/discussions  
Discord: https://discord.gg/g8u2t9dKgE  