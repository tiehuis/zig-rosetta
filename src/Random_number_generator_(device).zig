const std = @import("std");
const builtin = @import("builtin");

pub fn main() !void {
    var s: [4]u8 = undefined;
    try std.os.getRandomBytes(s[0..]);

    const n = std.mem.readInt(s[0..], u32, builtin.Endian.Little);
    std.debug.warn("{x}\n", n);
}
