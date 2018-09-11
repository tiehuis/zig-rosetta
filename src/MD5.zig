const std = @import("std");
const Md5 = std.crypto.Md5;

pub fn main() void {
    var buf: [Md5.digest_length]u8 = undefined;
    Md5.hash("The quick brown fox jumped over the lazy dog's back", buf[0..]);

    for (buf) |b| {
        std.debug.warn("{x}", b);
    }
    std.debug.warn("\n");
}
