const std = @import("std");

pub fn main() void {
    const dog = "Bejamin";
    const Dog = "Samba";
    const DOG = "Bernie";

    std.debug.warn("The three dogs named {}, {}, and {}\n", dog, Dog, DOG);
}
