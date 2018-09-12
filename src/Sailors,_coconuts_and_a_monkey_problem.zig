const std = @import("std");

fn valid(n: usize, nuts_: usize) bool {
    var k = n;
    var nuts = nuts_;

    while (k != 0) : ({
        k -= 1;
        nuts -= 1 + nuts / n;
    }) {
        if (nuts % n != 1) {
            return false;
        }
    }

    return nuts != 0 and nuts % n == 0;
}

pub fn main() void {
    var n: usize = 2;
    while (n < 10) : (n += 1) {
        var x: usize = 0;
        while (!valid(n, x)) : (x += 1) {}

        std.debug.warn("{}: {}\n", n, x);
    }
}
