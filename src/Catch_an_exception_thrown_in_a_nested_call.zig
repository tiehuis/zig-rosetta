// Zig doesn't have exceptions, but its error handling system can represent this control flow.

// Running this program will result in the following error-return-trace.

// U0 Caught
// error: U1
// ./Catch_an_exception_thrown_in_a_nested_call.zig:27:5: 0x2231b2 in ??? (run)
//     return if (!pred) error.U0 else error.U1;
//     ^
// ./Catch_an_exception_thrown_in_a_nested_call.zig:23:5: 0x22305b in ??? (run)
//     try baz(pred);
//     ^
// ./Catch_an_exception_thrown_in_a_nested_call.zig:27:5: 0x2231b2 in ??? (run)
//     return if (!pred) error.U0 else error.U1;
//     ^
// ./Catch_an_exception_thrown_in_a_nested_call.zig:23:5: 0x22305b in ??? (run)
//     try baz(pred);
//     ^
// ./Catch_an_exception_thrown_in_a_nested_call.zig:14:17: 0x222ff2 in ??? (run)
//                 return err;
//                 ^
// ./Catch_an_exception_thrown_in_a_nested_call.zig:31:5: 0x222e5d in ??? (run)
//     try foo();
//     ^

const std = @import("std");

fn foo() !void {
    var b = false;
    while (true) {
        bar(b) catch |err| switch (err) {
            error.U0 => std.debug.warn("U0 Caught\n"),
            error.U1 => {
                // Zig requires us to handle the error here. We can simulate
                // a rethrow by returning the error to the caller.
                return err;
            },
        };

        b = !b;
    }
}

fn bar(pred: bool) !void {
    try baz(pred);
}

fn baz(pred: bool) !void {
    return if (!pred) error.U0 else error.U1;
}

pub fn main() !void {
    try foo();
}
