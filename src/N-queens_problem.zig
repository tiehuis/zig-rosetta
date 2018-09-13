const std = @import("std");

fn nQueens(nn: usize) usize {
    std.debug.assert(nn <= 27);

    if (nn < 4) {
        return @boolToInt(nn == 1);
    }

    const ulen = usize.bit_count;
    const full = @maxValue(usize) - ((usize(1) << @intCast(u6, (ulen - nn))) - 1);
    const n = nn - 3;

    var l: [32]usize = undefined;
    var r: [32]usize = undefined;
    var c: [32]usize = undefined;
    var mm: [33]usize = undefined;

    var count: usize = 0;

    var b0 = usize(1) << @intCast(u6, (ulen - n - 3));
    while (b0 != 0) : (b0 <<= 1) {
        var b1 = b0 << 2;
        while (b1 != 0) : (b1 <<= 1) {
            var d = n;

            c[n] = b0 | b1;
            l[n] = (b0 << 2) | (b1 << 1);
            r[n] = (b0 >> 2) | (b1 >> 1);

            var bits = full & ~(l[n] | r[n] | c[n]);

            var mmi: usize = 1;
            mm[mmi] = bits;

            while (bits != 0) {
                while (d != 0) {
                    const pos = usize(1) << @intCast(u6, @ctz(bits));

                    bits &= ~pos;
                    if (bits != 0) {
                        mm[mmi] = bits | d;
                        mmi += 1;
                    }

                    d -= 1;
                    l[d] = (l[d + 1] | pos) << 1;
                    r[d] = (r[d + 1] | pos) >> 1;
                    c[d] = c[d + 1] | pos;

                    bits = full & ~(l[d] | r[d] | c[d]);

                    if (bits == 0) {
                        break;
                    }
                    if (d == 0) {
                        count += 1;
                        break;
                    }
                }

                mmi -= 1;
                bits = mm[mmi];
                d = bits & 31;
                bits &= ~usize(31);
            }
        }
    }

    return count * 2;
}

pub fn main() void {
    var i: usize = 0;
    while (i <= 12) : (i += 1) {
        std.debug.warn("N-queens({}) = {} solutions\n", i, nQueens(i));
    }
}
