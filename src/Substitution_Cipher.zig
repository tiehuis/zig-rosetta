const std = @import("std");

const key = "]kYV}(!7P$n5_0i R:?jOWtF/=-pe'AD&@r6%ZXs\"v*N[#wSl9zq2^+g;LoB`aGh{3.HIu4fbK)mU8|dMET><,Qc\\C1yxJ";

fn encode(out: []u8, in: []const u8) void {
    std.debug.assert(out.len >= in.len);

    for (in) |_, i| {
        out[i] = key[in[i] - 32];
    }
}

fn decode(out: []u8, in: []const u8) void {
    std.debug.assert(out.len >= in.len);

    for (in) |_, i| {
        out[i] = @truncate(u8, (std.mem.indexOfScalar(u8, key, in[i]) orelse unreachable) + 32);
    }
}

pub fn main() void {
    const s = "The quick brown fox jumps over the lazy dog, who barks VERY loudly!";

    var e: [s.len]u8 = undefined;
    encode(e[0..], s);
    std.debug.warn("Encoded: {}\n", e);

    var d: [s.len]u8 = undefined;
    decode(d[0..], e);
    std.debug.warn("Decoded: {}\n", d);
}
