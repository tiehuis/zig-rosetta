const std = @import("std");

fn ascii() []const u8 {
    comptime var alphabet: ['z' - 'a' + 1]u8 = undefined;
    comptime var i: u8 = 0;
    inline while ('a' + i <= 'z') : (i += 1) {
        alphabet[i] = 'a' + i;
    }
    return alphabet;
}

pub fn main() void {
    std.debug.warn("{}\n", ascii());
}
