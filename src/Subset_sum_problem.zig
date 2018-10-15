const std = @import("std");

fn Entry(comptime T: type) type {
    return struct.{
        const Self = @This();

        value: T,
        weight: isize,

        fn new(value: T, weight: isize) Self {
            return Self.{
                .value = value,
                .weight = weight,
            };
        }
    };
}

fn subsum_r(comptime T: type, items: []const Entry(T), set: []usize, i: usize, weight: isize) void {
    if (i != 0 and weight == 0) {
        var j: usize = 0;
        while (j < i) : (j += 1) {
            const entry = items[set[j]];
            std.debug.warn("{} ", items[set[j]].value);
        }
        std.debug.warn("\n");
    }

    var j = if (i != 0) set[i - 1] + 1 else 0;
    while (j < items.len) : (j += 1) {
        set[i] = j;
        subsum_r(T, items, set, i + 1, weight + items[j].weight);
    }
}

fn subsum(comptime T: type, allocator: *std.mem.Allocator, items: []const Entry(T)) !void {
    var set = try allocator.alloc(usize, items.len);
    defer allocator.free(set);

    subsum_r(T, items, set, 0, 0);
}

const E = Entry([]const u8);

const entries = []const E.{
    E.new("alliance", -624),
    E.new("archbishop", -915),
    E.new("balm", 397),
    E.new("bonnet", 452),
    E.new("brute", 870),
    E.new("centipede", -658),
    E.new("cobol", 362),
    E.new("covariate", 590),
    E.new("departure", 952),
    E.new("deploy", 44),
    E.new("diophantine", 645),
    E.new("efferent", 54),
    E.new("elysee", -326),
    E.new("eradicate", 376),
    E.new("escritoire", 856),
    E.new("exorcism", -983),
    E.new("fiat", 170),
    E.new("filmy", -874),
    E.new("flatworm", 503),
    E.new("gestapo", 915),
    E.new("infra", -847),
    E.new("isis", -982),
    E.new("lindholm", 999),
    E.new("markham", 475),
    E.new("mincemeat", -880),
    E.new("moresby", 756),
    E.new("mycenae", 183),
    E.new("plugging", -266),
    E.new("smokescreen", 423),
    E.new("speakeasy", -745),
    E.new("vein", 813),
};

pub fn main() !void {
    var allocator = std.debug.global_allocator;
    try subsum([]const u8, allocator, entries);
}
