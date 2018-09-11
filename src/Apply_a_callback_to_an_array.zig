const std = @import("std");

fn apply(comptime T: type, array: []const T, callback: fn (T, usize) void) void {
    for (array) |e, i| {
        callback(e, i);
    }
}

fn print(e: u8, i: usize) void {
    std.debug.warn("array[{}] = {}\n", i, e);
}

pub fn main() void {
    const array = []u8{ 1, 2, 3, 4 };
    apply(u8, array, print);
}
