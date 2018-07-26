const std = @import("std");
const Timer = std.os.time.Timer;

fn identity(x: usize) usize {
    return x;
}

fn sum(x: usize) usize {
    var n = x;
    var i: usize = 0;
    while (i < 1000000) : (i += 1) {
        n += i;
    }
    return n;
}

pub fn main() !void {
    var timer = try Timer.start();

    _ = identity(4);
    const t1 = timer.lap();

    _ = sum(4);
    const t2 = timer.lap();

    std.debug.warn("identity(4) {}ns\n", t1);
    std.debug.warn("     sum(4) {}ns\n", t2);
}
