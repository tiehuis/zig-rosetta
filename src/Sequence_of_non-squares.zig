const std = @import("std");

fn nonSquare(n: usize) usize {
    return n + @floatToInt(usize, 0.5 + std.math.sqrt(@intToFloat(f64, n)));
}

pub fn main() void {
    {
        var i: usize = 1;
        while (i < 23) : (i += 1) {
            std.debug.warn("{} ", nonSquare(i));
        }
        std.debug.warn("\n");
    }

    {
        var i: usize = 1;
        while (i < 1000000) : (i += 1) {
            const j = std.math.sqrt(@intToFloat(f64, nonSquare(i)));
            std.debug.assert(j != std.math.floor(j));
        }
    }
}
