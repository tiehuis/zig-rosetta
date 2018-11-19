const std = @import("std");

const IrNode = union(enum) {
    Addp: usize,
    Subp: usize,
    Add: u8,
    Sub: u8,
    Write,
    Read,
    Jz: usize,
    Jnz: usize,
};

// - Precomputes branch jump points.
// - Fuses adjacent instructions of same type.
fn compileBrainfuck(allocator: *std.mem.Allocator, program: []const u8) ![]IrNode {
    var jump_stack = std.ArrayList(usize).init(allocator);
    defer jump_stack.deinit();

    var nodes = std.ArrayList(IrNode).init(allocator);
    errdefer nodes.deinit();

    var i: usize = 0;
    while (i < program.len) : (i += 1) {
        switch (program[i]) {
            '>' => {
                var c: usize = 1;
                while (i + 1 < program.len and program[i + 1] == '>') : (i += 1) {
                    c += 1;
                }
                try nodes.append(IrNode{ .Addp = c });
            },
            '<' => {
                var c: usize = 1;
                while (i + 1 < program.len and program[i + 1] == '<') : (i += 1) {
                    c += 1;
                }
                try nodes.append(IrNode{ .Subp = c });
            },
            '+' => {
                var c: u8 = 1;
                while (i + 1 < program.len and program[i + 1] == '+') : (i += 1) {
                    c +%= 1;
                }
                try nodes.append(IrNode{ .Add = c });
            },
            '-' => {
                var c: u8 = 1;
                while (i + 1 < program.len and program[i + 1] == '-') : (i += 1) {
                    c +%= 1;
                }
                try nodes.append(IrNode{ .Sub = c });
            },
            '.' => try nodes.append(IrNode.Write),
            ',' => try nodes.append(IrNode.Read),
            '[' => {
                try jump_stack.append(nodes.len);
                try nodes.append(IrNode{ .Jz = undefined });
            },
            ']' => {
                const entry = jump_stack.popOrNull() orelse return error.UnmatchedBrackets;
                try nodes.append(IrNode{ .Jnz = entry });
                nodes.items[entry].Jz = nodes.len - 1;
            },
            else => {},
        }
    }

    if (jump_stack.len != 0) {
        return error.UnmatchedBrackets;
    }

    return nodes.toOwnedSlice();
}

fn executeBrainfuck(
    comptime tape_length: usize,
    allocator: *std.mem.Allocator,
    in: *std.os.File.InStream.Stream,
    out: *std.os.File.OutStream.Stream,
    program: []const u8,
) !void {
    var memory = []u8{0} ** tape_length;
    var mp: usize = 0;
    var pc: usize = 0;

    var bytecode = try compileBrainfuck(allocator, program);

    while (pc < bytecode.len) : (pc += 1) {
        switch (bytecode[pc]) {
            IrNode.Addp => |c| mp = (mp + c) % memory.len,
            IrNode.Subp => |c| mp = (mp + memory.len - c) % memory.len,
            IrNode.Add => |c| memory[mp] +%= c,
            IrNode.Sub => |c| memory[mp] -%= c,
            IrNode.Write => try out.print("{c}", memory[mp]),
            IrNode.Read => {
                memory[mp] = in.readByte() catch |err| switch (err) {
                    error.EndOfStream => return,
                    else => return err,
                };
            },
            IrNode.Jz => |c| {
                if (memory[mp] == 0) {
                    pc = c;
                }
            },
            IrNode.Jnz => |c| {
                if (memory[mp] != 0) {
                    pc = c;
                }
            },
        }
    }
}

pub fn main() !void {
    var allocator = std.debug.global_allocator;

    var stdin_file = try std.io.getStdIn();
    var stdin = stdin_file.inStream();

    var stdout_file = try std.io.getStdOut();
    var stdout = stdout_file.outStream();

    const hello_world_program =
        \\>++++++++[<+++++++++>-]<.>>+>+>++>[-]+<[>[->+<<++++>]<<]>.+++++++..+++.>
        \\>+++++++.<<<[[-]<[-]>]<+++++++++++++++.>>.+++.------.--------.>>+.>++++.
    ;

    try executeBrainfuck(30000, allocator, &stdin.stream, &stdout.stream, hello_world_program);
}
