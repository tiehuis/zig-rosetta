const std = @import("std");

pub fn main() !void {
    var allocator = std.debug.global_allocator;
    const args = try std.os.argsAlloc(allocator);
    defer std.os.argsFree(allocator, args);

    for (args) |arg| {
        std.debug.warn("{}\n", arg);
    }
}
