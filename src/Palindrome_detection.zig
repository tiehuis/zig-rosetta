const std = @import("std");

fn isPalindrome(s: []const u8) bool {
    var i: usize = 0;
    while (i < s.len / 2) : (i += 1) {
        if (s[i] != s[s.len - i - 1]) {
            return false;
        }
    }
    return true;
}

pub fn main() void {
    const s = "ingirumimusnocteetconsumimurigni";

    std.debug.warn("{}: {}\n", s, isPalindrome(s));
}
