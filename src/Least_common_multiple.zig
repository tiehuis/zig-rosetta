const std = @import("std");

fn gcd(comptime T: type, m_: T, n_: T) T {
    var m = m_;
    var n = n_;

    while (m != 0) {
        const t = m;
        m = n % m;
        n = t;
    }

    return n;
}

fn lcm(comptime T: type, m: T, n: T) T {
    return m / gcd(T, m, n) * n;
}

pub fn main() void {
    std.debug.warn("lcm(12, 18) = {}\n", lcm(usize, 12, 18));
}
