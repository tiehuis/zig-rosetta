const std = @import("std");

fn isPrime(n: var) bool {
    const T = @typeOf(n);
    std.debug.assert(@typeId(T) == @import("builtin").TypeId.Int);
    std.debug.assert(!T.is_signed);

    if (n % 2 == 0) {
        return n == 2;
    }
    if (n % 3 == 0) {
        return n == 3;
    }
    if (n % 5 == 0) {
        return n == 5;
    }

    const wheel = []T.{ 4, 2, 4, 2, 4, 6, 2, 6 };

    var k: T = 7;
    var i: usize = 1;
    while (k * k <= n) : (i = (i + 1) & 7) {
        if (n % k == 0) return false;
        k += wheel[i];
    }

    return true;
}

fn cell(xa: usize, ya: usize, na: usize) usize {
    var x = @intCast(isize, xa);
    var y = @intCast(isize, ya);
    const n = @intCast(isize, na);

    x = x - @divTrunc(n - 1, 2);
    y = y - @divTrunc(n, 2);
    const mx = if (x < 0) -x else x;
    const my = if (y < 0) -y else y;

    const l = 2 * std.math.max(mx, my);
    const d = if (y >= x) l * 3 + x + y else l - x - y;
    return @intCast(usize, (l - 1) * (l - 1) + d);
}

fn ulam(na: usize) void {
    const n = if (na % 2 == 0) na + 1 else na;

    var x: usize = 0;
    while (x < n) : (x += 1) {
        var y: usize = 0;
        while (y < n) : (y += 1) {
            const z = cell(y, x, n);
            if (isPrime(z)) {
                std.debug.warn("<>");
            } else {
                std.debug.warn("  ");
            }
        }
        std.debug.warn("\n");
    }
}

pub fn main() void {
    ulam(9);
}
