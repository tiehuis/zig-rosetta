const std = @import("std");

const Sieve = struct.{
    allocator: *std.mem.Allocator,
    bits: []usize,

    fn bin(n: usize) usize {
        return n >> std.math.log2(usize.bit_count);
    }

    fn mask(n: usize) usize {
        return usize(1) << @intCast(std.math.Log2Int(usize), (n & (usize.bit_count - 1)));
    }

    pub fn init(allocator: *std.mem.Allocator, n: usize) !Sieve {
        var bits = try allocator.alloc(usize, n / usize.bit_count + 1);
        std.mem.set(usize, bits, 0);
        bits[0] |= 0b11;

        var i: usize = 2;
        while (i < std.math.sqrt(n) + 1) : (i += 1) {
            if (bits[bin(i)] & mask(i) != 0) {
                continue;
            }

            var j: usize = i * i;
            while (j < n) : (j += i) {
                bits[bin(j)] |= mask(j);
            }
        }

        return Sieve.{
            .allocator = allocator,
            .bits = bits,
        };
    }

    pub fn deinit(self: *const Sieve) void {
        self.allocator.free(self.bits);
    }

    pub fn isPrime(self: *const Sieve, n: usize) bool {
        return self.bits[bin(n)] & mask(n) == 0;
    }
};

pub fn main() !void {
    const sieve = try Sieve.init(std.debug.global_allocator, 1000);
    defer sieve.deinit();

    const s = []usize.{ 2, 4, 5, 9, 97, 123, 124, 542, 997 };

    for (s) |e| {
        std.debug.warn("{}: {}\n", e, sieve.isPrime(e));
    }
}
