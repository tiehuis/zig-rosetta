const std = @import("std");

const unixdict = @embedFile("../dep/unixdict.txt");

var allocator = std.debug.global_allocator;

export fn do(u: [*]const u8, ulen: usize) void {
    var map = std.AutoHashMap([]const u8, std.ArrayList([]const u8)).init(allocator);
    defer map.deinit();

    var count: usize = 0;

    var lines = std.mem.split(u[0..ulen], "\n");
    while (lines.next()) |word| {
        var key: [64]u8 = undefined;
        std.mem.copy(u8, key[0..], word[0..word.len]);
        std.sort.sort(u8, key[0..word.len], std.sort.asc(u8));

        const entry = map.getOrPut(key) catch unreachable;
        if (!entry.found_existing) {
            entry.kv.value = std.ArrayList([]const u8).init(allocator);
        } else {
            entry.kv.value.append(word) catch unreachable;
        }

        count = std.math.max(count, entry.kv.value.len);
    }

    var it = map.iterator();
    while (it.next()) |entry| {
        if (entry.value.len >= count) {
            for (entry.value.toSliceConst()) |e| {
                std.debug.warn("{} ", e);
            }
            std.debug.warn("\n");
        }
    }
}

pub fn main() void {
    do(@ptrCast([*]const u8, &unixdict[0]), unixdict.len);
}
