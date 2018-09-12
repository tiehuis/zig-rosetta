const std = @import("std");

pub fn main() void {
    {
        var t: usize = 1;
        var i: usize = 0;
        while (i < 30) : (i += 1) {
            std.debug.warn("{} ", @popCount(t));
            t *= 3;
        }
        std.debug.warn("\n");
    }

    {
        var t: usize = 0;
        var i: usize = 0;
        while (i < 30) : (t += 1) {
            if (@popCount(t) % 2 == 0) {
                std.debug.warn("{} ", t);
                i += 1;
            }
        }
        std.debug.warn("\n");
    }

    {
        var t: usize = 0;
        var i: usize = 0;
        while (i < 30) : (t += 1) {
            if (@popCount(t) % 2 != 0) {
                std.debug.warn("{} ", t);
                i += 1;
            }
        }
        std.debug.warn("\n");
    }
}
