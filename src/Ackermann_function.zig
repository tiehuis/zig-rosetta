const std = @import("std");

fn ackermann(m: usize, n: usize) usize {
    if (m == 0) return n + 1;
    if (n == 0) return ackermann(m - 1, 1);
    return ackermann(m - 1, ackermann(m, n - 1));
}

pub fn main() void {
    var m: usize = 0;
    while (m <= 4) : (m += 1) {
        var n: usize = 0;
        while (n < 6 - m) : (n += 1) {
            std.debug.warn("A({}, {}) = {}\n", m, n, ackermann(m, n));
        }
    }
}
