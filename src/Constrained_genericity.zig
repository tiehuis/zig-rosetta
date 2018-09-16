const std = @import("std");
const builtin = @import("builtin");

// Constrained generics are done at compile-time via a userland implementation.
fn hasFunction(comptime T: type, name: []const u8) bool {
    const info = @typeInfo(T);
    for (info.Struct.defs) |def| {
        const DataType = @TagType(builtin.TypeInfo.Definition.Data);

        if (DataType(def.data) != DataType.Fn) {
            continue;
        }

        if (!std.mem.eql(u8, def.name, name)) {
            continue;
        }

        return true;
    }

    return false;
}

fn FoodBox(comptime T: type) type {
    if (!hasFunction(T, "eat")) {
        @compileError("Type " ++ @typeName(T) ++ " does not have required function `eat`");
    }

    return struct {
        const Self = @This();

        pub fn init() Self {
            return Self{};
        }
    };
}

const Carrot = struct {
    fn eat() void {}
};

const Car = struct {};

pub fn main() void {
    const box1 = FoodBox(Carrot).init();

    // Constrained_genericity.zig:26:9: error: Type Car does not have required function `eat`
    //         @compileError("Type " ++ @typeName(T) ++ " does not have required function `eat`");
    //         ^
    // Constrained_genericity.zig:46:25: note: called from here
    //     const box2 = FoodBox(Car).init();
    //                         ^

    // Will fail with the above error.
    // const box2 = FoodBox(Car).init();
}
