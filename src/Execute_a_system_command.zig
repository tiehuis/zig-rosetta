const std = @import("std");

pub fn main() !void {
    var allocator = std.debug.global_allocator;
    const result = try std.os.ChildProcess.exec(allocator, [][]const u8.{"ls"}, null, null, 1024 * 10);
    std.debug.warn("{}", result.stdout);
}
