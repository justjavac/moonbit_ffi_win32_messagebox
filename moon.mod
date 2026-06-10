name = "justjavac/win32_messagebox"

version = "0.1.3"

import {
  "justjavac/ffi@0.2.3",
}

readme = "README.md"

repository = "https://github.com/justjavac/moonbit_ffi_win32_messagebox"

license = "MIT"

keywords = [ "ffi", "win32", "messagebox", "windows" ]

description = "A MoonBit FFI demo for calling the Win32 MessageBoxW API."

preferred_target = "native"

options(
  source: "src",
)
