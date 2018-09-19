const std = @import("std");

fn map(a1: f64, a2: f64, b1: f64, b2: f64, s: f64) f64 {
    return b1 + (s - a1) * (b2 - b1) / (a2 - a1);
}

pub fn main() void {
    std.debug.warn("Mapping [0,10] to [-1,0] at intervals of 1:\n");

    var i: usize = 0;
    while (i <= 10) : (i += 1) {
        std.debug.warn("f({}) = {.1}\n", i, map(0, 10, -1, 0, @intToFloat(f64, i)));
    }
}
