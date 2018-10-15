const std = @import("std");

pub fn main() void {
    var s = []u8.{ 2, 4, 3, 1, 2 };
    std.sort.sort(u8, s[0..], std.sort.asc(u8));

    for (s) |b| {
        std.debug.warn("{} ", b);
    }
    std.debug.warn("\n");
}
