using AppKit;

namespace Uno.Sdk.Apps.Uno.macOS;

public static class MainClass
{
    public static void Main(string[] args)
    {
        NSApplication.Init();
        NSApplication.SharedApplication.Delegate = new App();
        NSApplication.Main(args);
    }
}
