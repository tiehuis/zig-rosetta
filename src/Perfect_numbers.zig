const std = @import("std");

fn isPerfect(n: usize) bool {
    const max = @floatToInt(usize, std.math.sqrt(@intToFloat(f64, n))) + 1;

    var tot: usize = 1;
    var i: usize = 2;
    while (i < max) : (i += 1) {
        if ((n % i) == 0) {
            tot += i;
            const q = n / i;
            if (q > i) {
                tot += q;
            }
        }
    }

    return tot == n;
}

pub fn main() void {
    var n: usize = 2;
    while (n < 10000) : (n += 1) {
        if (isPerfect(n)) {
            std.debug.warn("{}\n", n);
        }
    }
}
