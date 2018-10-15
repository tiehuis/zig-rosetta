const std = @import("std");
const math = std.math;

const shades = ".:!*oe&#%@";
const light = Vec3.new(30, 30, -50).norm();

const Vec3 = struct.{
    x: f64,
    y: f64,
    z: f64,

    fn new(x: f64, y: f64, z: f64) Vec3 {
        return Vec3.{ .x = x, .y = y, .z = z };
    }

    fn norm(v: Vec3) Vec3 {
        const len = math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z);
        return Vec3.new(v.x / len, v.y / len, v.z / len);
    }

    fn dot(u: Vec3, v: Vec3) f64 {
        const d = u.x * v.x + u.y * v.y + u.z * v.z;
        return math.fabs(d);
    }
};

fn clamp(comptime T: type, v: T, lower: T, upper: T) T {
    return math.min(math.max(v, lower), upper);
}

fn drawSphere(r: f64, k: f64, ambient: f64) void {
    var i = math.floor(-r);
    while (i <= math.ceil(r)) : (i += 1) {
        var j = math.floor(-2 * r);
        while (j < math.ceil(2 * r)) : (j += 1) {
            const x = i + 0.5;
            const y = j / 2 + 0.5;

            if (x * x + y * y <= r * r) {
                const v = Vec3.new(x, y, math.sqrt(r * r - x * x - y * y)).norm();
                const b = math.pow(f64, Vec3.dot(v, light), k) + ambient;

                const intensity = @floatToInt(isize, (1 - b) * @intToFloat(f64, shades.len));
                const intensity_c = clamp(isize, intensity, 0, @intCast(isize, shades.len - 2));

                std.debug.warn("{c}", shades[@intCast(usize, intensity_c)]);
            } else {
                std.debug.warn(" ");
            }
        }
        std.debug.warn("\n");
    }
}

pub fn main() void {
    drawSphere(20, 4, 0.1);
    drawSphere(10, 2, 0.4);
}
