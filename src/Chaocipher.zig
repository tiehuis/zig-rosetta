const std = @import("std");

const ChaoMode = enum {
    Encrypt,
    Decrypt,
};

const l_alphabet = "HXUCZVAMDSLKPEFJRIGTWOBNYQ";
const r_alphabet = "PTLNBQDEOYSFAVZKGJRIHWXUMC";

fn chao(output: []u8, input: []const u8, mode: ChaoMode, show_steps: bool) void {
    std.debug.assert(output.len >= input.len);

    var left: [26]u8 = undefined;
    var right: [26]u8 = undefined;
    var temp: [26]u8 = undefined;

    std.mem.copy(u8, left[0..], l_alphabet);
    std.mem.copy(u8, right[0..], r_alphabet);

    for (input) |_, i| {
        if (show_steps) {
            std.debug.warn("{}  {}\n", left, right);
        }

        var index: usize = undefined;
        switch (mode) {
            ChaoMode.Encrypt => {
                index = std.mem.indexOfScalar(u8, right, input[i]) orelse unreachable;
                output[i] = left[index];
            },
            ChaoMode.Decrypt => {
                index = std.mem.indexOfScalar(u8, left, input[i]) orelse unreachable;
                output[i] = right[index];
            },
        }

        if (i == input.len - 1) {
            break;
        }

        var j: usize = undefined;
        var store: u8 = undefined;

        // permute left
        j = index;
        while (j < 26) : (j += 1) {
            temp[j - index] = left[j];
        }
        j = 0;
        while (j < index) : (j += 1) {
            temp[26 - index + j] = left[j];
        }
        store = temp[1];
        j = 2;
        while (j < 14) : (j += 1) {
            temp[j - 1] = temp[j];
        }
        temp[13] = store;
        std.mem.copy(u8, left[0..], temp[0..]);

        // permute right
        j = index;
        while (j < 26) : (j += 1) {
            temp[j - index] = right[j];
        }
        j = 0;
        while (j < index) : (j += 1) {
            temp[26 - index + j] = right[j];
        }
        store = temp[0];
        j = 1;
        while (j < 26) : (j += 1) {
            temp[j - 1] = temp[j];
        }
        temp[25] = store;
        store = temp[2];
        j = 3;
        while (j < 14) : (j += 1) {
            temp[j - 1] = temp[j];
        }
        temp[13] = store;
        std.mem.copy(u8, right[0..], temp[0..]);
    }
}

pub fn main() void {
    const plain_text = "WELLDONEISBETTERTHANWELLSAID";

    var cipher_text: [plain_text.len]u8 = undefined;
    var plain_text2: [plain_text.len]u8 = undefined;

    std.debug.warn(
        \\The original plaintext is : {}
        \\
    ,
        plain_text,
    );
    std.debug.warn(
        \\
        \\The left and right alphabets after each permutation during encryption are :
        \\
        \\
    );

    chao(cipher_text[0..], plain_text, ChaoMode.Encrypt, true);

    std.debug.warn(
        \\
        \\The ciphertext is : {}
        \\
    ,
        cipher_text,
    );

    chao(plain_text2[0..], cipher_text, ChaoMode.Decrypt, false);

    std.debug.warn(
        \\
        \\The recovered plaintext is : {}
        \\
    ,
        plain_text2,
    );
}
