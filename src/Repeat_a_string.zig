const std = @import("std");

fn repeat(allocator: *std.mem.Allocator, s: []const u8, n: usize) ![]const u8 {
    var buf = try allocator.alloc(u8, s.len * n);

    var i: usize = 0;
    while (i < n) : (i += 1) {
        std.mem.copy(u8, buf[i * s.len ..], s);
    }

    return buf;
}

pub fn main() void {
    std.debug.warn("{}\n", "ha" ** 5);
    std.debug.warn("{}\n", repeat(std.debug.global_allocator, "ha", 5));
}
