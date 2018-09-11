const std = @import("std");

pub fn main() !void {
    var buffer: [std.os.MAX_PATH_BYTES]u8 = undefined;
    const path = try std.os.selfExePath(&buffer);
    std.debug.warn("{}\n", path);
}
