const std = @import("std");

fn levenshtein(s: []const u8, t: []const u8) usize {
    if (s.len == 0) {
        return t.len;
    }

    if (t.len == 0) {
        return s.len;
    }

    if (s[s.len - 1] == t[t.len - 1]) {
        return levenshtein(s[0 .. s.len - 1], t[0 .. t.len - 1]);
    }

    var a = levenshtein(s[0 .. s.len - 1], t[0 .. t.len - 1]);
    var b = levenshtein(s, t[0 .. t.len - 1]);
    var c = levenshtein(s[0 .. s.len - 1], t);

    if (a > b) a = b;
    if (a > c) a = c;

    return a + 1;
}

pub fn main() void {
    const s1 = "rosettacode";
    const s2 = "raisethysword";

    std.debug.warn("distance between `{}' and `{}': {}\n", s1, s2, levenshtein(s1, s2));
}
