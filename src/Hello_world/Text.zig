const std = @import("std");

pub fn main() !void {
    var stdout = try std.io.getStdIn();
    try stdout.write("Hello world!\n");
}
