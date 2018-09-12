const std = @import("std");

const size = 1 << 4;

pub fn main() void {
    var y: isize = size - 1;
    while (y >= 0) : (y -= 1) {
        var i: isize = 0;
        while (i < y) : (i += 1) {
            std.debug.warn(" ");
        }

        var x: isize = 0;
        while (x + y < size) : (x += 1) {
            if (x & y != 0) {
                std.debug.warn("  ");
            } else {
                std.debug.warn("* ");
            }
        }

        std.debug.warn("\n");
    }
}
