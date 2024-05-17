const std = @import("std");

pub fn main() !void {
    _ = try std.io.getStdErr().write("Hello world!\n");
}
