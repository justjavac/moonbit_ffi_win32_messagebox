fn main {
  ignore(message_box(
    0,
    @ffi.to_wstr("Hello from MoonBit"),
    @ffi.to_wstr("MoonBit Message Box"),
    0,
  ))
}
