const std = @import("std");

fn TwoDim(comptime T: type) type {
    return struct {
        const Self = @This();
        allocator: *std.mem.Allocator,
        items: []T,
        stride: usize,

        pub fn init(allocator: *std.mem.Allocator, x: usize, y: usize) !Self {
            var items = try allocator.alloc(T, x * y);
            std.mem.set(T, items, 0);

            return Self{
                .allocator = allocator,
                .items = items,
                .stride = x,
            };
        }

        pub fn deinit(self: *const Self) void {
            self.allocator.free(self.items);
        }

        pub inline fn at(self: *const Self, i: usize, j: usize) T {
            return self.items[i + j * self.stride];
        }

        pub inline fn set(self: *Self, i: usize, j: usize, entry: T) void {
            self.items[i + j * self.stride] = entry;
        }
    };
}

fn lcs(allocator: *std.mem.Allocator, a: []const u8, b: []const u8) ![]u8 {
    var c = try TwoDim(usize).init(allocator, a.len + 1, b.len + 1);
    defer c.deinit();

    var i: usize = undefined;
    var j: usize = undefined;
    var k: usize = undefined;

    i = 1;
    while (i <= a.len) : (i += 1) {
        j = 1;
        while (j <= b.len) : (j += 1) {
            if (a[i - 1] == b[j - 1]) {
                c.set(i, j, c.at(i - 1, j - 1) + 1);
            } else {
                c.set(i, j, std.math.max(c.at(i - 1, j), c.at(i, j - 1)));
            }
        }
    }

    var t = c.at(a.len, b.len);
    var s = try allocator.alloc(u8, t);

    i = a.len;
    j = b.len;
    k = t;
    while (k > 0) {
        if (a[i - 1] == b[j - 1]) {
            s[k - 1] = a[i - 1];
            i -= 1;
            j -= 1;
            k -= 1;
        } else if (c.at(i, j - 1) > c.at(i - 1, j)) {
            j -= 1;
        } else {
            i -= 1;
        }
    }

    return s;
}

pub fn main() !void {
    var direct = std.heap.DirectAllocator.init();
    var allocator = &direct.allocator;

    const s = try lcs(allocator, "thisisatest", "testing123testing");
    std.debug.warn("{}\n", s);
}
