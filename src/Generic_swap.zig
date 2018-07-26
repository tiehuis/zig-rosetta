const std = @import("std");

fn swap(comptime T: type, a: *T, b: *T) void {
    const tmp = a.*;
    a.* = b.*;
    b.* = tmp;
}

pub fn main() void {
    var a: usize = 3;
    var b: usize = 5;

    swap(usize, &a, &b);
    std.debug.warn("{} {}\n", a, b);

    swap(usize, &a, &b);
    std.debug.warn("{} {}\n", a, b);
}

