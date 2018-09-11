const std = @import("std");
const ArrayList = std.ArrayList;

var allocator = std.debug.global_allocator;

fn runtimeAppend() !void {
    var a = ArrayList(u8).init(allocator);
    defer a.deinit();
    try a.appendSlice([]u8{ 0, 1, 2, 3, 4 });

    var b = ArrayList(u8).init(allocator);
    defer b.deinit();
    try b.appendSlice([]u8{ 10, 11, 12, 13 });

    try a.appendSlice(b.toSliceConst());
    std.debug.assert(std.mem.eql(u8, a.toSliceConst(), []u8{ 0, 1, 2, 3, 4, 10, 11, 12, 13 }));
}

fn comptimeAppend() void {
    const a = []u8{ 0, 1, 2, 3, 4 };
    const b = []u8{ 10, 11, 12, 13 };

    const c = a ++ b;
    std.debug.assert(std.mem.eql(u8, c, []u8{ 0, 1, 2, 3, 4, 10, 11, 12, 13 }));
}

pub fn main() !void {
    try runtimeAppend();
    comptimeAppend();
}
