const std = @import("std");

fn isLeapYear(y: var) bool {
    return (y % 4 == 0) and (y % 100 != 0 or y % 400 == 0);
}

pub fn main() void {
    const cases = []u32{
        1900, 1994, 1996, 1997, 2000,
    };

    for (cases) |y| {
        std.debug.warn("{}: {}\n", y, isLeapYear(y));
    }
}
