fn printType(x: var) void {
    @import("std").debug.warn("{}\n", @typeName(@typeOf(x)));
}

const C = struct {};
const E = union(enum) {
    Field,
};

pub fn main() void {
    printType(1);
    printType(usize(1));
    printType(1.0);
    printType(f64(1.0));
    printType('c');
    printType("string");
    printType(C{});
    printType(E.Field);
}
