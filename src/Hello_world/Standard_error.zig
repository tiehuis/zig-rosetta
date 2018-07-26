const std = @import("std");

pub fn main() !void {
    var stderr = try std.io.getStdErr();
    try stderr.write("Hello world!\n");
}
