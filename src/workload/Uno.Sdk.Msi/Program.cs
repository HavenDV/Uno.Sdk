using WixSharp;

namespace Uno.Sdk;

internal class Program
{
    #region Main

    private static void Main()
    {
        try
        {
            CreateMsi(Platform.x86);
            CreateMsi(Platform.x64);
            CreateMsi(Platform.arm64);
        }
        catch (Exception exception)
        {
            Console.WriteLine(exception.Message);
        }
    }

    #endregion

    #region Methods

    private static void CreateMsi(Platform platform)
    {
        var project = new Project(
            "Uno.Sdk.Manifest",
            new Dir(
                @"%ProgramFiles%\dotnet\sdk-manifests",
                new DirFiles(
                    @"..\..\..\artifacts\workload-manifest\*.*")),
            new Dir(
                @"%ProgramFiles%\dotnet\packs",
                new DirFiles(
                    @"..\..\..\artifacts\nuget\H.Uno.Sdk.*.nupkg")),
            new Dir(
                @"%ProgramFiles%\dotnet\template-packs",
                new DirFiles(
                    @"..\..\..\artifacts\nuget\H.Uno.Templates.*.nupkg")))
        {
            GUID = new Guid("DD1277EF-5DB9-497F-90EB-1A12039DB4F1"),
            ControlPanelInfo =
            {
                Manufacturer = "Uno Platform",
                ProductIcon = @"assets\icon.ico",
                Readme = "https://github.com/unoplatform/uno",
                HelpLink = "https://github.com/unoplatform/uno",
                UrlInfoAbout = "https://github.com/unoplatform/uno",
                UrlUpdateInfo = "https://github.com/unoplatform/uno",
                Contact = "Uno Platform",
            },
            UI = WUI.WixUI_ProgressOnly,
            Version = typeof(Program).Assembly.GetName().Version,
            MajorUpgrade = MajorUpgrade.Default,
            InstallScope = InstallScope.perMachine,
            Name = $"Uno.Sdk.Manifest-{platform:G}",
            Properties = new[]
            {
                // https://documentation.help/Windows-Installer/msifastinstall.htm
                // Disables system restore point creation, some checks and progress messages.
                new Property("MSIFASTINSTALL", "7"),
            },
            Platform = platform,
        };

        Compiler.CandleOptions += " -nologo";
        Compiler.LightOptions += " -nologo";
        
        _ = Compiler.BuildMsi(project);
    }

    #endregion
}
