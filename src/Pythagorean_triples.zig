const std = @import("std");

const TripleCount = struct {
    prims: u64,
    total: u64,
};

fn countTriples(x: u64, y: u64, z: u64, limit: u64) TripleCount {
    var count = TripleCount{
        .prims = 0,
        .total = 0,
    };

    var a = x;
    var b = y;
    var c = z;

    var i: u64 = undefined;
    var j: u64 = undefined;
    var k: u64 = undefined;

    while (true) {
        const p = a + b + c;
        if (p > limit) {
            break;
        }

        count.prims += 1;
        count.total += limit / p;

        i = a -% 2 *% b +% 2 *% c;
        j = 2 *% a -% b +% 2 *% c;
        k = j -% b +% c;

        const c1 = countTriples(i, j, k, limit);
        count.prims += c1.prims;
        count.total += c1.total;

        i += 4 * b;
        j += 2 * b;
        k += 4 * b;

        const c2 = countTriples(i, j, k, limit);
        count.prims += c2.prims;
        count.total += c2.total;

        c = k - 4 * a;
        b = j - 4 * a;
        a = i - 2 * a;
    }

    return count;
}

pub fn main() void {
    var limit: usize = 10;
    while (limit <= 100000000) : (limit *= 10) {
        const c = countTriples(3, 4, 5, limit);
        std.debug.warn("Up to {}: {} triples, {} primitives.\n", limit, c.total, c.prims);
    }
}
