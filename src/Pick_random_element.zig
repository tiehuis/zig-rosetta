const std = @import("std");

pub fn main() void {
    const s = "abcdefgh";

    var prng = std.rand.DefaultPrng.init(0);
    std.debug.warn("{c}\n", s[prng.random.range(usize, 0, s.len)]);
}
