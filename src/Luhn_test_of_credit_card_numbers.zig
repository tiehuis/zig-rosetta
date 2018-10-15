const std = @import("std");

fn digit(s: u8) ?u8 {
    return if ('0' <= s and s <= '9') s - '0' else null;
}

fn luhn(id: []const u8) bool {
    const mapping = []const u8.{ 0, 2, 4, 6, 8, 1, 3, 5, 7, 9 };

    var odd = true;
    var sum: usize = 0;

    for (id) |_, i| {
        const d = digit(id[id.len - i - 1]) orelse return false;
        sum += if (odd) d else mapping[d];
        odd = !odd;
    }

    return sum % 10 == 0;
}

pub fn main() void {
    const ids = [][]const u8.{
        "49927398716",
        "49927398717",
        "1234567812345678",
        "1234567812345670",
    };

    for (ids) |id| {
        std.debug.warn("{}: {}\n", id, luhn(id));
    }
}
