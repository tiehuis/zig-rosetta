const std = @import("std");
const Compare = std.mem.Compare;

fn stringsAreEqual(list: []const []const u8) bool {
    for (list) |s| {
        if (std.mem.compare(u8, list[0], s) != Compare.Equal) {
            return false;
        }
    }
    return true;
}

fn stringsAreInAscendingOrder(list: []const []const u8) bool {
    for (list[1..]) |_, i| {
        switch (std.mem.compare(u8, list[i], list[i + 1])) {
            Compare.LessThan => {},
            else => return false,
        }
    }
    return true;
}

pub fn main() void {
    const lists = [][]const []const u8.{
        [][]const u8.{ "AA", "BB", "CC" },
        [][]const u8.{ "AA", "AA", "AA" },
        [][]const u8.{ "AA", "CC", "BB" },
        [][]const u8.{ "AA", "ACB", "BB", "CC" },
        [][]const u8.{"single_element"},
    };

    for (lists) |list| {
        std.debug.warn("list: ");
        for (list) |e| {
            std.debug.warn("{} ", e);
        }
        std.debug.warn("\n");

        std.debug.warn("    equal: {}\n", stringsAreEqual(list));
        std.debug.warn("ascending: {}\n", stringsAreInAscendingOrder(list));
        std.debug.warn("\n");
    }
}
