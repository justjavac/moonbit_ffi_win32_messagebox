///|
/// ```c
/// int MessageBox(
///   [in, optional] HWND    hWnd,
///   [in, optional] LPCTSTR lpText,
///   [in, optional] LPCTSTR lpCaption,
///   [in]           UINT    uType
/// );
/// ```
pub extern "C" fn message_box(
  hWnd : Int,
  lpText : Bytes,
  lpCaption : Bytes,
  uType : Int
) -> Int = "MessageBoxW"

///|
/// This is a simple example of how to use the `message_box` function.
fn main {
  let caption = "MoonBit Message Box\u{0}"
  let text = "Hello World\n你好，世界\nこんにちは世界\nBonjour le monde\nمرحبا بالعالم\u{0}"
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
