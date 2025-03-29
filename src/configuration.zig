pub const Backend = enum {
    Naive,
    Accelerate,
    Metal,
};

pub const Configuration = struct { backend: Backend = .Naive };
