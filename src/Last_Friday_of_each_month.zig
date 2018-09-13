const std = @import("std");

fn isLeapYear(y: var) bool {
    return (y % 4 == 0) and (y % 100 != 0 or y % 400 == 0);
}

fn lastFridaysOfYear(y: usize) void {
    const months = []usize{ 31, usize(28) + @boolToInt(isLeapYear(y)), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

    var w = y * 365 + (y - 1) / 4 - (y - 1) / 100 + (y - 1) / 400 + 6;
    for (months) |days, m| {
        w = (w + days) % 7;
        std.debug.warn("{}-{}-{}\n", y, m + 1, if (w < 5) days - 2 - w else days + 5 - w);
    }
}

pub fn main() void {
    lastFridaysOfYear(2012);
}
