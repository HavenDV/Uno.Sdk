using GLib;
#if __UNO5__
using Uno.UI.Runtime.Skia.Gtk;
#else
using Uno.UI.Runtime.Skia;
#endif

namespace UnoTemplate.Skia.Gtk;

public class Program
{
	public static void Main(string[] args)
	{
		ExceptionManager.UnhandledException += delegate (UnhandledExceptionArgs expArgs)
		{
			Console.WriteLine("GLIB UNHANDLED EXCEPTION" + expArgs.ExceptionObject.ToString());
			expArgs.ExitApplication = true;
		};

#if __UNO5__
		var host = new GtkHost(() => new App());
#else
		var host = new GtkHost(() => new App(), args);
#endif

		host.Run();
	}
}
