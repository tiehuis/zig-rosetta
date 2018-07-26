const std = @import("std");

pub fn main() void {
    const s = "The quick brown fox jumps over the lazy dog";
    std.debug.warn("{x}\n", std.hash.Crc32.hash(s));
}
