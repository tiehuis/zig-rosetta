const std = @import("std");
const builtin = @import("builtin");

pub fn main() void {
    std.debug.warn(" Word Size: {}\n", usize(@sizeOf(usize)));
    std.debug.warn("Endianness: {}\n", builtin.endian);
}
