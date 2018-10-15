const std = @import("std");

var rng = std.rand.DefaultPrng.init(0);

fn shuffle(comptime T: type, a: []T) void {
    var i: usize = a.len - 1;
    while (i > 0) : (i -= 1) {
        const j = rng.random.range(usize, 0, i + 1);
        const tmp = a[i];
        a[i] = a[j];
        a[j] = tmp;
    }
}

pub fn main() void {
    var s = []u8.{ 0, 1, 2, 3, 4 };

    shuffle(u8, s[0..]);

    for (s[0..]) |b|
        std.debug.warn("{} ", b);
    std.debug.warn("\n");
}
