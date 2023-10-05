namespace Uno.Sdk.Apps.Uno.Skia.Wpf;

public class Program
{
	[STAThread]
	public static void Main(string[] args)
	{
		var app = new System.Windows.Application();
		var window = new System.Windows.Window
		{
			Content = new System.Windows.Controls.ContentControl
			{
				Content = new global::Uno.UI.Skia.Platform.WpfHost(app.Dispatcher, () => new App()),
			}
		};
		
		window.Show();
		app.Run();
	}
}