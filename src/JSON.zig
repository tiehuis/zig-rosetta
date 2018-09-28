const std = @import("std");

pub fn main() !void {
    var allocator = std.debug.global_allocator;

    var p = std.json.Parser.init(allocator, false);
    defer p.deinit();

    var tree = try p.parse(
        \\{
        \\    "foo": 1,
        \\    "bar": [
        \\        10,
        \\        "apples"
        \\    ]
        \\}
    );
    defer tree.deinit();

    var root = tree.root;

    const foo = root.Object.get("foo").?.value.Integer;
    const bar = root.Object.get("bar").?.value.Array.toSliceConst();

    std.debug.warn("foo: {}\n", foo);
    std.debug.warn("bar[0]: {}\n", bar[0].Integer);
    std.debug.warn("bar[1]: {}\n", bar[1].String);
}
