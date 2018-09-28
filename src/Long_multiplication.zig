const std = @import("std");

const Digit = u32;
const Digit2 = @IntType(false, 2 * Digit.bit_count);

pub fn mul(allocator: *std.mem.Allocator, a: []const Digit, b: []const Digit) ![]const Digit {
    var r = try allocator.alloc(Digit, a.len + b.len);

    std.mem.set(Digit, r[0..], 0);

    for (a) |_, i| {
        var c: Digit = 0;
        var j: usize = 0;
        while (j < b.len) : (j += 1) {
            const e = Digit2(r[i + j]) + Digit2(a[i]) * Digit2(b[j]) + Digit2(c);
            r[i + j] = @truncate(Digit, e);
            c = @truncate(Digit, e >> Digit.bit_count);
        }
        r[i + j] = c;
    }

    var hi: usize = r.len - 1;
    while (r[hi] != 0 and hi > 0) : (hi -= 1) {}
    return allocator.shrink(Digit, r, hi);
}

pub fn main() !void {
    var allocator = std.debug.global_allocator;

    // 18446744073709551616
    const s1 = []const Digit{ 0, 0, 1 };
    // 340282366920938463463374607431768211456
    const s2 = []const Digit{ 0, 0, 0, 0, 1 };

    const r = try mul(allocator, s1, s1);
    std.debug.assert(std.mem.eql(Digit, r, s2));
}
