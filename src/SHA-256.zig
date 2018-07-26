const std = @import("std");
const Sha256 = std.crypto.Sha256;

pub fn main() void {
    var buf: [Sha256.digest_size]u8 = undefined;
    Sha256.hash("Rosetta code", buf[0..]);

    for (buf) |b| {
        std.debug.warn("{x}", b);
    }
    std.debug.warn("\n");
}
