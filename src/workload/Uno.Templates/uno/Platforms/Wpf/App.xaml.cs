namespace Uno.Sdk.Apps.Uno.Wpf.Skia;

public partial class App : global::System.Windows.Application
{
    public App()
    {
        new System.Windows.Window
        {
            Content = new System.Windows.Controls.ContentControl
            {
                Content = new global::Uno.UI.Skia.Platform.WpfHost(Dispatcher, () => new global::Uno.Sdk.Apps.Uno.App()),
            }
        }.Show();
        
        //var host = new WpfHost(Dispatcher, () => new global::Uno.Sdk.Apps.Uno.App());
        //host.Run();
    }
}