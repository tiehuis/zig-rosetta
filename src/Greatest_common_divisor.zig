const std = @import("std");

pub fn gcd(comptime T: type, u: T, v: T) T {
    var a = u;
    var b = v;

    while (b > 0) {
        const c = @mod(a, b);
        a = b;
        b = c;
    }

    return if (a < 0) -a else a;
}

pub fn main() void {
    std.debug.warn("{}\n", gcd(usize, 20, 4));
}
