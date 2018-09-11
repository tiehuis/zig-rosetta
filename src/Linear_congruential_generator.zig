const std = @import("std");

const Lcg = struct {
    const rand_max = (1 << 31) - 1;

    r: u32,

    pub fn init(seed: u32) Lcg {
        return Lcg{ .r = seed };
    }

    pub fn reseed(self: *Lcg, seed: u32) void {
        self.r = seed;
    }

    pub fn randBsd(self: *Lcg) u32 {
        self.r = (self.r *% 1103515245 +% 12345) & rand_max;
        return self.r;
    }

    pub fn randMs(self: *Lcg) u32 {
        self.r = (self.r *% 214013 +% 2531011) & rand_max;
        return self.r >> 16;
    }
};

pub fn main() void {
    var rnd = Lcg.init(0);

    {
        var i: usize = 0;
        while (i < 10) : (i += 1) {
            std.debug.warn("{}\n", rnd.randBsd());
        }
    }

    std.debug.warn("\n");
    rnd.reseed(0);

    {
        var i: usize = 0;
        while (i < 10) : (i += 1) {
            std.debug.warn("{}\n", rnd.randMs());
        }
    }
}
