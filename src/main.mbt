///|
/// Win32 MessageBoxW FFI demo.
///
/// This package demonstrates calling the Windows `MessageBoxW` API from
/// MoonBit through native FFI. It uses `justjavac/ffi` to convert MoonBit
/// strings to UTF-16 wide strings before passing them to User32.

///|
/// FFI binding to the Windows `MessageBoxW` API.
///
/// `MessageBoxW` displays a modal dialog box containing application-specific
/// text, an optional icon, and one or more buttons. It accepts UTF-16 wide
/// strings, so callers should convert MoonBit strings with `@ffi.to_wstr`.
///
/// Parameters:
///
/// - `hWnd`: owner window handle, or `0` for no owner.
/// - `lpText`: UTF-16 message text.
/// - `lpCaption`: UTF-16 dialog title.
/// - `uType`: Windows MessageBox flags such as `MB_OK`, `MB_YESNO`, or icon
///   flags.
///
/// Common return values:
///
/// - `1`: OK.
/// - `2`: Cancel.
/// - `6`: Yes.
/// - `7`: No.
/// - `0`: API call failed.
///
/// Example:
///
/// ```mbt nocheck
/// let result = message_box(
///   0,
///   @ffi.to_wstr("Save changes before closing?"),
///   @ffi.to_wstr("Unsaved Changes"),
///   0x00000023,
/// )
/// ```
#borrow(lpText, lpCaption)
pub extern "C" fn message_box(
  hWnd : Int,
  lpText : Bytes,
  lpCaption : Bytes,
  uType : Int,
) -> Int = "MessageBoxW"

///|
/// Display the demo message box.
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
