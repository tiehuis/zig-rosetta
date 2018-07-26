const std = @import("std");

pub fn main() void {
    var s = "asdf";

    std.mem.reverse(u8, s[0..]);
    std.debug.warn("{}\n", s);
}
