const std = @import("std");

fn rot13b(c: u8) u8 {
    if (('a' <= c and c <= 'm') or ('A' <= c and c <= 'M')) {
        return c + 13;
    } else if (('n' <= c and c <= 'z') or ('N' <= c and c <= 'Z')) {
        return c - 13;
    } else {
        return c;
    }
}

fn rot13(s: []u8) void {
    for (s) |*b| {
        b.* = rot13b(b.*);
    }
}

pub fn main() void {
    var s = "The Quick Brown Fox Jumps Over The Lazy Dog!";

    rot13(s[0..]);
    std.debug.warn("{}\n", s);
}
