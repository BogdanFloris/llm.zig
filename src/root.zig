const std = @import("std");
const testing = std.testing;

pub const Tensor = @import("./tensor.zig").Tensor;
pub const Configuration = @import("./configuration.zig").Configuration;

test {
    _ = @import("./tensor.zig");
    _ = @import("./configuration.zig");
}
