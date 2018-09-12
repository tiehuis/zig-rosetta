const std = @import("std");

fn reverseWordsInOrder(s: []u8, delim: u8) void {
    if (s.len == 0) return;

    var p = s;
    while (true) {
        const i = std.mem.indexOfScalar(u8, p, delim) orelse p.len;
        std.mem.reverse(u8, p[0..i]);

        if (i == p.len) {
            return;
        }
        p = p[i + 1 ..];
    }
}

fn reverseOrderOfWords(s: []u8, delim: u8) void {
    std.mem.reverse(u8, s);
    reverseWordsInOrder(s, delim);
}

pub fn main() void {
    const original = "rosetta code phrase reversal";
    const delim = ' ';
    var copy: [original.len]u8 = undefined;

    std.debug.warn("Original:       \"{}\"\n", original);

    std.mem.copy(u8, copy[0..], original);
    std.mem.reverse(u8, copy[0..]);
    std.debug.warn("Reversed:       \"{}\"\n", copy);

    std.mem.copy(u8, copy[0..], original);
    reverseWordsInOrder(copy[0..], delim);
    std.debug.warn("Reversed words: \"{}\"\n", copy);

    std.mem.copy(u8, copy[0..], original);
    reverseOrderOfWords(copy[0..], delim);
    std.debug.warn("Reversed order: \"{}\"\n", copy);
}
