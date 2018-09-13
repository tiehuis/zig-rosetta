const std = @import("std");

pub fn main() !void {
    const n = 100000;
    var direct = std.heap.DirectAllocator.init();
    defer direct.deinit();
    var allocator = &direct.allocator;

    var q = try allocator.alloc(u32, n + 1);
    defer allocator.free(q);

    q[1] = 1;
    q[2] = 1;

    {
        var i: usize = 3;
        while (i <= n) : (i += 1) {
            q[i] = q[i - q[i - 1]] + q[i - q[i - 2]];
        }
    }

    {
        var i: usize = 1;
        std.debug.warn("Q(1..10) :");
        while (i <= 10) : (i += 1) {
            std.debug.warn(" {}", q[i]);
        }

        std.debug.warn("\nQ(1000)  : {}\n", q[1000]);
    }

    {
        var i: usize = 1;
        var flip: usize = 0;
        while (i < n) : (i += 1) {
            flip += @boolToInt(q[i] > q[i + 1]);
        }

        std.debug.warn("Q(i) is less than Q(i-1) for i [2..100_000] {} times.\n", flip);
    }
}
