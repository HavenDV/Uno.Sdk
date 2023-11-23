namespace Uno.Resizetizer
{
    /// <summary>
    /// Extension methods for the <see cref="global::Microsoft.UI.Xaml.Window" /> class.
    /// </summary>
    public static class WindowExtensions2
    {
        /// <summary>
        /// This will set the Window Icon for the given <see cref="global::Microsoft.UI.Xaml.Window" /> using
        /// the provided UnoIcon.
        /// </summary>
        public static void SetWindowIcon(this global::Microsoft.UI.Xaml.Window window)
        {
			var hWnd =
			global::WinRT.Interop.WindowNative.GetWindowHandle(window);

			// Retrieve the WindowId that corresponds to hWnd.
			global::Microsoft.UI.WindowId windowId =
			global::Microsoft.UI.Win32Interop.GetWindowIdFromWindow(hWnd);

			// Lastly, retrieve the AppWindow for the current (XAML) WinUI 3 window.
			global::Microsoft.UI.Windowing.AppWindow appWindow =
				global::Microsoft.UI.Windowing.AppWindow.GetFromWindowId(windowId);
			appWindow.SetIcon("iconapp.ico");
        }
    }
}