///|
/// # Win32 Message Box FFI Demo
/// 
/// This module demonstrates how to use FFI (Foreign Function Interface) to call
/// Windows API functions from MoonBit. Specifically, it shows how to display
/// a Windows message box using the `MessageBoxW` function from the Windows API.
/// 
/// ## Features
/// 
/// - **Direct Win32 API access**: Calls native Windows API functions
/// - **Unicode support**: Uses `MessageBoxW` for full Unicode text support
/// - **UTF-16 string conversion**: Demonstrates proper string encoding for Windows
/// - **Error handling**: Shows how to handle Win32 API return values
/// - **Multi-language support**: Displays text in multiple languages
/// 
/// ## Windows API Reference
/// 
/// This demo uses the `MessageBoxW` function from the Windows API:
/// 
/// ```c
/// int MessageBoxW(
///   [in, optional] HWND    hWnd,      // Handle to owner window
///   [in, optional] LPCWSTR lpText,    // Message text (UTF-16)
///   [in, optional] LPCWSTR lpCaption, // Dialog title (UTF-16)
///   [in]           UINT    uType      // Message box type and behavior
/// );
/// ```
/// 
/// ## Usage Examples
/// 
/// ```moonbit
/// // Basic message box
/// let result = message_box(0, 
///   @ffi.to_wstr("Hello, World!"), 
///   @ffi.to_wstr("My App"), 
///   0x00000000)
/// 
/// // Message box with Yes/No buttons
/// let result = message_box(0,
///   @ffi.to_wstr("Do you want to continue?"),
///   @ffi.to_wstr("Confirmation"),
///   0x00000004)  // MB_YESNO
/// 
/// // Error message box
/// let result = message_box(0,
///   @ffi.to_wstr("An error occurred!"),
///   @ffi.to_wstr("Error"),
///   0x00000010)  // MB_ICONERROR
/// ```
/// 
/// ## Return Values
/// 
/// The function returns different values based on user interaction:
/// - `1` (IDOK): User clicked OK
/// - `2` (IDCANCEL): User clicked Cancel
/// - `6` (IDYES): User clicked Yes
/// - `7` (IDNO): User clicked No
/// - `0`: Function failed
/// 
/// ## Platform Requirements
/// 
/// - **Windows only**: This demo only works on Windows systems
/// - **UTF-16 encoding**: Requires proper wide string conversion
/// - **User32.dll**: Uses the standard Windows User32 library

///|
/// FFI binding to Windows MessageBoxW API function.
/// 
/// This function displays a modal dialog box that contains a system icon,
/// a set of buttons, and a brief application-specific message. The user
/// can interact with the dialog by clicking one of the buttons.
/// 
/// This is a direct FFI binding to the Windows `MessageBoxW` function,
/// which uses UTF-16 (wide character) strings for full Unicode support.
/// 
/// ## Parameters
/// 
/// - `hWnd`: Handle to the owner window of the message box. Use `0` for no owner
/// - `lpText`: The message text to display (must be UTF-16 encoded)
/// - `lpCaption`: The dialog box title (must be UTF-16 encoded)
/// - `uType`: The contents and behavior of the dialog box (combination of flags)
/// 
/// ## Common uType Values
/// 
/// **Button types:**
/// - `0x00000000` (MB_OK): OK button only
/// - `0x00000001` (MB_OKCANCEL): OK and Cancel buttons
/// - `0x00000004` (MB_YESNO): Yes and No buttons
/// - `0x00000003` (MB_YESNOCANCEL): Yes, No, and Cancel buttons
/// 
/// **Icon types:**
/// - `0x00000010` (MB_ICONERROR): Error icon
/// - `0x00000020` (MB_ICONQUESTION): Question icon
/// - `0x00000030` (MB_ICONWARNING): Warning icon
/// - `0x00000040` (MB_ICONINFORMATION): Information icon
/// 
/// ## Returns
/// 
/// An integer indicating which button the user clicked:
/// - `1` (IDOK): OK button
/// - `2` (IDCANCEL): Cancel button
/// - `6` (IDYES): Yes button
/// - `7` (IDNO): No button
/// - `0`: Function failed
/// 
/// ## Example
/// 
/// ```moonbit nocheck
/// let result = message_box(0,
///   @ffi.to_wstr("Save changes before closing?"),
///   @ffi.to_wstr("Unsaved Changes"),
///   0x00000023)  // MB_ICONQUESTION | MB_YESNOCANCEL
///
/// match result {
///   1 => println("User clicked OK")
///   2 => println("User clicked Cancel")
///   6 => println("User clicked Yes")
///   7 => println("User clicked No")
///   0 => println("Message box failed")
///   _ => println("Unexpected result")
/// }
/// ```
/// 
/// ## Note
/// 
/// - This function is Windows-specific and will not work on other platforms
/// - String parameters must be converted to UTF-16 using `@ffi.to_wstr()`
/// - The message box is modal and blocks execution until user interaction
/// - Use `0` for hWnd to create a system modal dialog
#borrow(lpText, lpCaption)
pub extern "C" fn message_box(
  hWnd : Int,
  lpText : Bytes,
  lpCaption : Bytes,
  uType : Int,
) -> Int = "MessageBoxW"

///|
/// Main function demonstrating Win32 message box usage.
/// 
/// This function serves as a demonstration of how to use the `message_box`
/// FFI binding to display a Windows message box with multilingual text.
/// It shows proper UTF-16 string conversion and error handling.
/// 
/// The demo displays a message box with:
/// - A custom title: "MoonBit Message Box"
/// - Multilingual greeting text in English, Chinese, Japanese, French, and Arabic
/// - Basic error handling for the API call
/// 
/// ## Example Output
/// 
/// When successful, this will display a Windows message box with the text:
/// ```
/// Hello World
/// 你好，世界
/// こんにちは世界
/// Bonjour le monde
/// مرحبا بالعالم
/// ```
/// 
/// ## Error Handling
/// 
/// The function checks the return value from `message_box()`:
/// - If `0`: The API call failed (prints error message)
/// - If non-zero: The message box was displayed successfully
/// 
/// ## Note
/// 
/// This function demonstrates FFI usage and proper string encoding for Windows APIs.
/// In a real application, you would typically want more sophisticated error handling
/// and user interface management.
fn main {
  let caption = "MoonBit Message Box"
  let text = "Hello World\n你好，世界\nこんにちは世界\nBonjour le monde\nمرحبا بالعالم"
  let msg_id = message_box(
    0,
    @ffi.to_wstr(text),
    @ffi.to_wstr(caption),
    0x00000000,
  )
  if msg_id == 0 {
    // Handle error
    println("Failed to display message box.")
  } else {
    println("Message box displayed successfully.")
  }
}

///|
test "wide string conversion" {
  let bytes = @ffi.to_wstr("MoonBit")
  assert_true(bytes.length() > 0)
}
