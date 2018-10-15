const std = @import("std");

fn horner(c: []const f64, v: f64) f64 {
    var r: f64 = 0.0;
    for (c) |_, ri| {
        r = r * v + c[c.len - ri - 1];
    }
    return r;
}

pub fn main() void {
    const c = []const f64.{ -19, 7, -4, 6 };
    std.debug.warn("{.5}\n", horner(c, 3.0));
}
