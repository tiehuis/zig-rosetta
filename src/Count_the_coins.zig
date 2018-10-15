const std = @import("std");

fn changes(allocator: *std.mem.Allocator, amount: usize, coins: []const usize) !u128 {
    const n = coins.len;

    var cycle: usize = 0;
    for (coins) |c| {
        if (c <= amount and c >= cycle) {
            cycle = c + 1;
        }
    }
    cycle *= n;

    const table = try allocator.alloc(u128, cycle);
    defer allocator.free(table);
    std.mem.set(u128, table[0..n], 1);
    std.mem.set(u128, table[n..], 0);

    var pos = n;
    var s: usize = 1;
    while (s < amount + 1) : (s += 1) {
        var i: usize = 0;
        while (i < n) : (i += 1) {
            if (i == 0 and pos >= cycle) {
                pos = 0;
            }
            if (coins[i] <= s) {
                const q = @intCast(isize, pos) - @intCast(isize, coins[i] * n);
                table[pos] = if (q >= 0)
                    table[@intCast(usize, q)]
                else
                    table[@intCast(usize, q + @intCast(isize, cycle))];
            }
            if (i != 0) {
                table[pos] += table[pos - 1];
            }

            pos += 1;
        }
    }

    return table[pos - 1];
}

pub fn main() void {
    var direct = std.heap.DirectAllocator.init();
    defer direct.deinit();
    var allocator = &direct.allocator;

    const coin_sets = [][]const usize.{
        // us coins
        []const usize.{ 100, 50, 25, 10, 5, 1 },
        // eu coins
        []const usize.{ 200, 100, 50, 20, 10, 5, 2, 1 },
    };

    for (coin_sets) |coins| {
        std.debug.warn("{}\n", changes(allocator, 100, coins[2..]));
        std.debug.warn("{}\n", changes(allocator, 100000, coins));
        std.debug.warn("{}\n", changes(allocator, 1000000, coins));
        std.debug.warn("{}\n", changes(allocator, 10000000, coins));
    }
}
