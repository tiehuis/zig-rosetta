const std = @import("std");

const mean = 1.0;
const stddev = 0.5;
const n = 1000;

pub fn main() !void {
    var buf: [8]u8 = undefined;
    try std.os.getRandomBytes(buf[0..]);
    const seed = std.mem.readIntLE(u64, buf[0..8]);
    var prng = std.rand.DefaultPrng.init(seed);

    var numbers: [n]f64 = undefined;
    for (numbers) |*e| {
        e.* = prng.random.floatNorm(f64) * stddev + mean;
    }

    var s: f64 = 0;
    var sq: f64 = 0;
    for (numbers) |e| {
        s += e;
    }

    const cm = s / n;
    for (numbers) |e| {
        const d = e - cm;
        sq += d * d;
    }

    std.debug.warn("mean {}, stddev {}\n", cm, std.math.sqrt(sq / (n - 1)));
}
