const std = @import("std");

fn modInv(a_: i64, b_: i64) i64 {
    var a = a_;
    var b = b_;

    if (b < 0) b = -b;
    if (a < 0) a = b - @mod(-a, b);

    var t: i64 = 0;
    var nt: i64 = 1;
    var r = b;
    var nr = @mod(a, b);

    while (nr != 0) {
        const q = @divTrunc(r, nr);
        const t1 = nt;
        nt = t - q * nt;
        t = t1;
        const t2 = nr;
        nr = r - q * nr;
        r = t2;
    }

    if (r > 1) return -1;
    if (t < 0) t += b;
    return t;
}

pub fn main() void {
    std.debug.warn("{}\n", modInv(42, 2017));
    std.debug.warn("{}\n", modInv(40, 1));
    std.debug.warn("{}\n", modInv(52, -217));
    std.debug.warn("{}\n", modInv(-486, 217));
    std.debug.warn("{}\n", modInv(40, 2018));
}
