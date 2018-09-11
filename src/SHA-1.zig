const std = @import("std");
const Sha1 = std.crypto.Sha1;

pub fn main() void {
    var buf: [Sha1.digest_length]u8 = undefined;
    Sha1.hash("Rosetta Code", buf[0..]);

    for (buf) |b| {
        std.debug.warn("{x}", b);
    }
    std.debug.warn("\n");
}
