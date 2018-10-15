const std = @import("std");

const W = 81;
const H = 5;

var lines = [][W]u8.{[]u8.{'#'} ** W} ** H;

fn cantor(start: usize, len: usize, index: usize) void {
    var seg = len / 3;
    if (seg == 0) return;

    var i = index;
    while (i < H) : (i += 1) {
        var j = start + seg;
        while (j < start + seg * 2) : (j += 1) {
            lines[i][j] = ' ';
        }
    }

    cantor(start, seg, index + 1);
    cantor(start + seg * 2, seg, index + 1);
}

pub fn main() void {
    cantor(0, W, 1);

    for (lines) |line| {
        std.debug.warn("{}\n", line);
    }
}
