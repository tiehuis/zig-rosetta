const std = @import("std");

pub fn main() void {
    const TFruit = enum.{
        Apple,
        Banana,
        Cherry,
    };

    const TApe = enum(u8).{
        Gorilla = 0,
        Chimpanzee = 1,
        Orangutan = 5,
    };

    std.debug.warn("{} {}\n", TApe.Gorilla, @enumToInt(TApe.Orangutan));
}
