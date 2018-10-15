const std = @import("std");

const Period = struct.{
    s: []const u8,
    v: u32,
};

fn secondsToString(buffer: []u8, seconds: u32) []u8 {
    std.debug.assert(buffer.len >= 32);

    const periods = []Period.{
        Period.{ .s = "wk", .v = 604800 },
        Period.{ .s = "d", .v = 86400 },
        Period.{ .s = "hr", .v = 3600 },
        Period.{ .s = "min", .v = 60 },
        Period.{ .s = "sec", .v = 1 },
    };

    var rem = seconds;
    var len: usize = 0;

    for (periods) |p| {
        const c = rem / p.v;
        rem %= p.v;

        if (c != 0) {
            const s = std.fmt.bufPrint(buffer[len..], "{} {}, ", c, p.s) catch unreachable;
            len += s.len;
        }

        if (rem == 0) {
            break;
        }
    }

    return if (len != 0) buffer[0 .. len - 2] else buffer[0..0];
}

pub fn main() void {
    var buf: [32]u8 = undefined;

    std.debug.warn("{}\n", secondsToString(buf[0..], 7259));
    std.debug.warn("{}\n", secondsToString(buf[0..], 86400));
    std.debug.warn("{}\n", secondsToString(buf[0..], 6000000));
}
