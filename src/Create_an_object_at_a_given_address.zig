const std = @import("std");

pub fn main() void {
    var m: u8 = undefined;

    // From a known pointer value (&m), traverse the prior 128-bytes of the stack
    // and print the values. `a` can be any integer and is converted into an
    // address via @intToPtr.
    var a = @ptrToInt(&m);
    var i: usize = 0;
    while (i < 128) : (i += 8) {
        const p = @intToPtr(*u64, a + i);
        std.debug.warn("{x}: {x}\n", a + i, p.*);
    }
}
