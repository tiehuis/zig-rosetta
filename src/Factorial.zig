const std = @import("std");

pub fn factorial(comptime n: comptime_int) comptime_int {
    return if (n > 0) n * factorial(n - 1) else 1;
}

pub fn main() void {
    std.debug.warn("{}\n", u128(factorial(30)));
}
