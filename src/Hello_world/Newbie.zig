// - Install zig from https://ziglang.org/download/.
// - Extract into your path
// - `zig run Newbie.zig`

const std = @import("std");

pub fn main() void {
    std.debug.warn("Hello, World!\n");
}
