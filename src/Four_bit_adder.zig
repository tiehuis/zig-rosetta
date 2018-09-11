const std = @import("std");

inline fn xor(comptime T: type, x: T, y: T) T {
    return (~x & y) | (x & ~y);
}

inline fn halfAdder(comptime T: type, a: T, b: T, s: *T, c: *T) void {
    s.* = xor(T, a, b);
    c.* = a & b;
}

inline fn fullAdder(comptime T: type, a: T, b: T, ic: T, s: *T, oc: *T) void {
    var ps: T = undefined;
    var pc: T = undefined;
    var tc: T = undefined;

    halfAdder(T, a, b, &ps, &pc);
    halfAdder(T, ps, ic, s, &tc);
    oc.* = tc | pc;
}

fn fourBitAdder(
    comptime T: type,
    a0: T,
    a1: T,
    a2: T,
    a3: T,
    b0: T,
    b1: T,
    b2: T,
    b3: T,
    o0: *T,
    o1: *T,
    o2: *T,
    o3: *T,
    overflow: *T,
) void {
    std.debug.assert(@typeId(T) == @import("builtin").TypeId.Int);
    std.debug.assert(!T.is_signed);

    var tc0: T = undefined;
    var tc1: T = undefined;
    var tc2: T = undefined;

    fullAdder(T, a0, b0, 0, o0, &tc0);
    fullAdder(T, a1, b1, tc0, o1, &tc1);
    fullAdder(T, a2, b2, tc1, o2, &tc2);
    fullAdder(T, a3, b3, tc2, o3, overflow);
}

pub fn main() void {
    const T = u32;

    const one: T = @maxValue(T);
    const zero: T = @minValue(T);

    var a0 = zero;
    var a1 = one;
    var a2 = zero;
    var a3 = zero;

    var b0 = zero;
    var b1 = one;
    var b2 = one;
    var b3 = one;

    var s0: T = undefined;
    var s1: T = undefined;
    var s2: T = undefined;
    var s3: T = undefined;
    var overflow: u32 = undefined;

    fourBitAdder(T, a0, a1, a2, a3, b0, b1, b2, b3, &s0, &s1, &s2, &s3, &overflow);

    std.debug.warn(
        \\      a3 {b}
        \\      a2 {b}
        \\      a1 {b}
        \\      a0 {b}
        \\      +
        \\      b3 {b}
        \\      b2 {b}
        \\      b1 {b}
        \\      b0 {b}
        \\      =
        \\      s3 {b}
        \\      s2 {b}
        \\      s1 {b}
        \\      s0 {b}
        \\overflow {b}
        \\
    , a3, a2, a1, a0, b3, b2, b1, b0, s3, s2, s1, s0, overflow);
}
