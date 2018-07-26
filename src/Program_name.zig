const std = @import("std");

pub fn main() !void {
    const path = try std.os.selfExePath(std.debug.global_allocator);
    std.debug.warn("{}\n", path);
}
