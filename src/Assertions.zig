const std = @import("std");

pub fn main() void {
    // Compile-time assertion
    comptime std.debug.assert(@sizeOf(usize) == 8);

    // Runtime assertion
    var a: usize = undefined;
    std.debug.assert(a == 42);
}
