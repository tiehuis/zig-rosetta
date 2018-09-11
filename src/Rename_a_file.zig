const std = @import("std");

pub fn main() !void {
    try std.os.rename("input.txt", "output.txt");
    try std.os.rename("docs", "mydocs");
    try std.os.rename("/input.txt", "/output.txt");
    try std.os.rename("/docs", "/mydocs");
}
