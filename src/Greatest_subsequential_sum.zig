const std = @import("std");

fn maxSubSeq(comptime T: type, seq: []const T) []const T {
    var max: T = 0;
    var sum: T = 0;

    var i: usize = 0;
    var start: ?usize = null;
    var end: ?usize = null;

    for (seq) |e, j| {
        sum += e;
        if (sum < 0) {
            i = j + 1;
            sum = 0;
        } else if (sum > max) {
            max = sum;
            start = i;
            end = j;
        }
    }

    if (start != null and end != null) {
        return seq[start.? .. end.? + 1];
    } else {
        return seq[0..0];
    }
}

pub fn main() void {
    const a1 = []isize.{ -1, -2, 3, 5, 6, -2, -1, 4, -4, 2, -1 };
    const a2 = []isize.{ -1, -2, -3, -5, -6, -2, -1, -4, -4, -2, -1 };

    std.debug.warn("[ ");
    for (maxSubSeq(isize, a1)) |e| {
        std.debug.warn("{} ", e);
    }
    std.debug.warn("]\n");

    std.debug.warn("[ ");
    for (maxSubSeq(isize, a2)) |e| {
        std.debug.warn("{} ", e);
    }
    std.debug.warn("]\n");
}
