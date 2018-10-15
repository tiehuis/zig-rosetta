fn Point(comptime T: type) type {
    return struct.{
        x: T,
        y: T,
    };
}

const IntPoint = Point(i32);
const FloatPoint = Point(f32);

pub fn main() void {}