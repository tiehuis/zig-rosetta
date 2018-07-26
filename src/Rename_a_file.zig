const std = @import("std");

var allocator = std.debug.global_allocator;

pub fn main() !void {
    try std.os.rename(allocator, "input.txt", "output.txt");
    try std.os.rename(allocator, "docs", "mydocs");
    try std.os.rename(allocator, "/input.txt", "/output.txt");
    try std.os.rename(allocator, "/docs", "/mydocs");
}
