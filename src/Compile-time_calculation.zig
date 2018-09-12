const std = @import("std");

fn factorial(comptime n: comptime_int) comptime_int {
    return if (n != 0) n * factorial(n - 1) else 1;
}

pub fn main() void {
    std.debug.warn("{}\n", usize(factorial(10)));

    {
        // comptime_int is arbitrary precision and comptime functions are cached
        // so the recursive solution provided above is fast. The comptime evaluation
        // limit is low so needs to be explicitly raised for this to be given
        // enough cycles to run.
        @setEvalBranchQuota(10000);
        std.debug.warn("{}\n", u64((factorial(1000) >> 512) % 100000));
    }
}
