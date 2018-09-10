const std = @import("std");

pub fn main() !void {
    var file = try std.os.File.openRead("File_size.zig");
    std.debug.warn("{}\n", try file.getEndPos());
}
