const std = @import("std");

async fn print(message: []const u8) void {
    std.debug.warn("{}\n", message);
}

pub fn main() !void {
    var allocator = std.debug.global_allocator;

    var loop: std.event.Loop = undefined;
    try loop.initMultiThreaded(allocator);
    defer loop.deinit();

    const h1 = try loop.call(print, "Enjoy");
    defer cancel h1;

    const h2 = try loop.call(print, "Rosetta");
    defer cancel h2;

    const h3 = try loop.call(print, "Code");
    defer cancel h3;

    loop.run();
}
