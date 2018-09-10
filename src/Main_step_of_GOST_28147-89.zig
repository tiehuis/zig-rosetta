const std = @import("std");

fn Kbox(comptime k: comptime_int, comptime sbox: [8][16]u4) [256]u8 {
    var a: [256]u8 = undefined;
    for (a) |*e, i| {
        e.* = (u8(sbox[k][i >> 4]) << 4) | (sbox[k - 1][i & 0xf]);
    }
    return a;
}

fn f(x: u32) u32 {
    const sbox = [8][16]u4{
        []u4{ 4, 10, 9, 2, 13, 8, 0, 14, 6, 11, 1, 12, 7, 15, 5, 3 },
        []u4{ 14, 11, 4, 12, 6, 13, 15, 10, 2, 3, 8, 1, 0, 7, 5, 9 },
        []u4{ 5, 8, 1, 13, 10, 3, 4, 2, 14, 15, 12, 7, 6, 0, 9, 11 },
        []u4{ 7, 13, 10, 1, 0, 8, 9, 15, 14, 4, 6, 12, 11, 2, 5, 3 },
        []u4{ 6, 12, 7, 1, 5, 15, 13, 8, 4, 10, 9, 14, 0, 3, 11, 2 },
        []u4{ 4, 11, 10, 0, 7, 2, 1, 13, 3, 6, 8, 5, 9, 12, 15, 14 },
        []u4{ 13, 11, 4, 1, 3, 15, 5, 9, 0, 10, 14, 7, 6, 8, 2, 12 },
        []u4{ 1, 15, 13, 0, 5, 7, 10, 4, 9, 2, 3, 14, 6, 11, 8, 12 },
    };

    var y: u32 = 0;

    comptime var i = 4;
    inline while (i > 0) : (i -= 1) {
        @setEvalBranchQuota(2000);
        const kbox = comptime Kbox(2 * i - 1, sbox);
        const shift = 8 * (i - 1);
        y |= u32(kbox[(x >> shift) & 0xff]) << shift;
    }

    return y;
}

fn mainStep(n: u64, k: u32) u64 {
    var n1 = @truncate(u32, n);
    var n2 = @intCast(u32, n >> 32);

    var s = n1 +% k;
    s = f(s);
    s = (s << 11) | (s >> 21);
    s ^= n2;
    n2 = n1;
    n1 = s;

    return (u64(n1) << 32) | n2;
}

pub fn main() void {
    std.debug.warn("{x}\n", mainStep(0x04320430043B0421, 0xE2C104F9));
}
