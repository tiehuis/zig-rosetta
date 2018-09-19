const std = @import("std");

fn base2() u64 {
    const diff = []u64{ 4, 2, 2, 2 };

    var k: usize = 0;
    var n: u64 = 9876432;

    loop: while (true) {
        var buf: [32]u8 = undefined;
        const s = std.fmt.bufPrint(buf[0..], "{}", n) catch unreachable;

        for (s) |c, i| {
            if (c == '0' or c == '5' or n % (c - '0') != 0) {
                n -= diff[k];
                k = (k + 1) & 3;
                continue :loop;
            }

            for (s[i + 1 ..]) |d| {
                if (c == d) {
                    n -= diff[k];
                    k = (k + 1) & 3;
                    continue :loop;
                }
            }
        }

        break;
    }

    return n;
}

fn divByAll(n: u64, digits: []const u8) bool {
    for (digits) |d| {
        const c = if (d <= '9') d - '0' else d - 'W';
        if (n % c != 0) {
            return false;
        }
    }

    return true;
}

fn base16() u64 {
    const magic = 15 * 14 * 13 * 12 * 11;
    const high: u64 = 0xfedcba987654321 / magic * magic;

    var i = high;
    while (i >= magic) : (i -= magic) {
        if (i & 15 == 0) {
            continue;
        }

        var buf: [32]u8 = undefined;
        const s = std.fmt.bufPrint(buf[0..], "{x}", i) catch unreachable;

        if (std.mem.indexOfScalar(u8, s, '0') != null) {
            continue;
        }

        var sd: [32]u8 = undefined;
        var found = []bool{false} ** 16;
        var len: usize = 0;

        for (s) |c| {
            const d = if (c <= '9') c - '0' else c - 'W';
            if (!found[d]) {
                found[d] = true;
                sd[len] = c;
                len += 1;
            }
        }

        if (len != s.len) {
            continue;
        }

        if (divByAll(i, sd[0..s.len])) {
            return i;
        }
    }

    return 0;
}

pub fn main() void {
    std.debug.warn("base  2: {}\n", base2());
    std.debug.warn("base 16: {x}\n", base16());
}
