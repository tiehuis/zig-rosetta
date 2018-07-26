const std = @import("std");

pub fn fibonacci(comptime n: comptime_int) comptime_int {
    return if (n >= 2) fibonacci(n - 1) + fibonacci(n - 2) else n;
}

pub fn main() void {
    std.debug.warn("{}\n", u128(fibonacci(100)));
}
