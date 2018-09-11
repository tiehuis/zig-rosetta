const std = @import("std");

var direct = std.heap.DirectAllocator.init();
var allocator = &direct.allocator;

pub fn main() !void {
    const file = try std.io.readFileAlloc(allocator, "Read_entire_file.zig");
    defer allocator.free(file);

    std.debug.warn("file size: {}\n", file.len);
}
