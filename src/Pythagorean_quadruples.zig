const std = @import("std");

const N = 2200;
const N2 = N * N * 2;

pub fn main() !void {
    var direct = std.heap.DirectAllocator.init();
    defer direct.deinit();
    var allocator = &direct.allocator;

    var r = try allocator.alloc(bool, N + 1);
    std.mem.set(bool, r[0..], false);
    defer allocator.free(r);

    var ab = try allocator.alloc(bool, N2 + 1);
    std.mem.set(bool, ab[0..], false);
    defer allocator.free(ab);

    var a: usize = 1;
    while (a <= N) : (a += 1) {
        const a2 = a * a;
        var b = a;
        while (b <= N) : (b += 1) {
            ab[a2 + b * b] = true;
        }
    }

    var s: usize = 3;
    var c: usize = 1;
    while (c <= N) : (c += 1) {
        var s1 = s;
        s += 2;
        var s2 = s;
        var d = c + 1;
        while (d <= N) : (d += 1) {
            if (ab[s1]) {
                r[d] = true;
            }
            s1 += s2;
            s2 += 2;
        }
    }

    var d: usize = 1;
    while (d <= N) : (d += 1) {
        if (!r[d]) {
            std.debug.warn("{} ", d);
        }
    }
    std.debug.warn("\n");
}
