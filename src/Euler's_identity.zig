const std = @import("std");
const Complex = std.math.Complex(f64);
const complex = std.math.complex;

pub fn main() void {
    const r = complex.exp(Complex.new(0, std.math.pi)).add(Complex.new(1, 0));
    std.debug.warn("e ^ πi + 1 = [{}, {}] ≅ 0\n", r.re, r.im);
}
