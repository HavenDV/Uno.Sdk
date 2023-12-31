using Microsoft.Extensions.Hosting;
using Uno.Resizetizer;
using Uno.Sdk.Apps.Views;
using Uno.UI;

namespace Uno.Sdk.Apps.Uno;

public sealed partial class App : Application
{
    private IHost Host { get; }
    private Window? MainWindow { get; set; }
    
	/// <summary>
	/// Initializes the singleton application object. This is the first line of authored code
	/// executed, and as such is the logical equivalent of main() or WinMain().
	/// </summary>
	public App()
	{
		Host = UnoProgram.CreateUnoApp();

		InitializeComponent();
	}

	/// <summary>
	/// Invoked when the application is launched normally by the end user.  Other entry points
	/// will be used such as when the application is launched to open a specific file.
	/// </summary>
	/// <param name="args">Details about the launch request and process.</param>
	protected override void OnLaunched(LaunchActivatedEventArgs args)
	{
#if NET6_0_OR_GREATER && WINDOWS && !HAS_UNO
		MainWindow = new Window();
#else
		MainWindow = Microsoft.UI.Xaml.Window.Current;
#endif
		
#if DEBUG
		MainWindow.EnableHotReload();
#endif
		
		// Do not repeat app initialization when the Window already has content,
		// just ensure that the window is active
		if (MainWindow.Content is not Frame rootFrame)
		{
			// Create a Frame to act as the navigation context and navigate to the first page
			rootFrame = new Frame();

			// Place the frame in the current Window
			MainWindow.Content = rootFrame;

			rootFrame.NavigationFailed += OnNavigationFailed;
		}

		if (rootFrame.Content is null)
		{
			// When the navigation stack isn't restored navigate to the first page,
			// configuring the new page by passing required information as a navigation
			// parameter
			//rootFrame.Navigate(typeof(MainView), args.Arguments);
            
			rootFrame.Content = new MainView();
		}

		// Ensure the current window is active
		MainWindow.Activate();

		MainWindow.SetWindowIcon();
	}
	
	/// <summary>
	/// Invoked when Navigation to a certain page fails
	/// </summary>
	/// <param name="sender">The Frame which failed navigation</param>
	/// <param name="e">Details about the navigation failure</param>
	void OnNavigationFailed(object sender, NavigationFailedEventArgs e)
	{
		throw new InvalidOperationException($"Failed to load {e.SourcePageType.FullName}: {e.Exception}");
	}
}
