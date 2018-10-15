const std = @import("std");

pub fn main() void {
    std.debug.warn("{}\n", std.mem.max(u8, []const u8.{ 0, 2, 32, 4, 0 }));
}
