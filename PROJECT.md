# 🚀 Project Design: Porting `llm.c` to Zig with Mac Accelerate and Metal

## 📘 Overview

This project aims to reimplement Andrej Karpathy's `llm.c`—a minimal LLM training codebase—in **Zig**, leveraging **Apple’s Accelerate** framework for hardware-optimized linear algebra on macOS (CPU/GPU/NPU). The goal is to retain `llm.c`'s minimalism and educational clarity while improving performance and portability on Apple silicon.

---

## 🎯 Objectives

- Reimplement core features of `llm.c` in Zig.
- Replace CUDA operations with Accelerate-compatible APIs (`vDSP`, `BNNS`, etc.).
- Use Zig’s memory safety, compile-time features, and performance to make a clear, idiomatic, and fast implementation.
- Provide modular architecture for easy extension (e.g., model size, dataset, tokenizer).
- Maintain a CLI training interface similar to `llm.c`.

---

## 🧱 Project Structure

```
zig-llm/
│
├── src/
│   ├── main.zig             # Entry point
│   ├── model.zig            # Transformer model (params, forward pass)
│   ├── trainer.zig          # Training loop logic (loss, grads, SGD)
│   ├── tensor.zig           # Tensor abstraction (backed by Accelerate)
│   ├── utils.zig            # I/O utilities, tokenizer, data prep
│   └── math/
│       ├── matmul.zig       # Matrix ops (Accelerate wrappers)
│       └── softmax.zig      # Softmax/activation functions
│
├── build.zig                # Zig build system
├── README.md
└── test/
    └── test_model.zig       # Unit tests for model components
```

---

## 🛠️ Dependencies

- **Zig** 0.12 or newer
- **Accelerate framework** (macOS):
  - `vDSP` – vector/matrix ops
  - `BNNS` – neural network primitives
  - `Metal` for future GPU acceleration
- **Tokenizer**: Use existing GPT-2 tokenizer; ideally integrate a Zig-compatible version of `tiktoken` or pre-tokenized datasets.

---

## 🔁 Implementation Milestones

### Phase 1: Scaffolding

- [ ] Set up Zig project and build.zig
- [ ] Implement basic tensor structure and Accelerate wrapper (vDSP/BNNS)
- [ ] Port `llm.c`’s data loading and parameter initialization

### Phase 2: Core Model

- [ ] Implement self-attention and layer norm using vDSP
- [ ] Port MLP and residual blocks
- [ ] Create forward pass for transformer block

### Phase 3: Training Engine

- [ ] Implement loss computation (e.g., cross-entropy)
- [ ] Write SGD / Adam optimizer (Accelerate-based)
- [ ] Training loop + evaluation interface

### Phase 4: CLI + UX

- [ ] Create CLI for training config (model size, epochs, etc.)
- [ ] Add progress bar, logging, stats output
- [ ] Model checkpointing + saving

### Phase 5: Testing + Benchmarking

- [ ] Write unit tests for each module
- [ ] Validate against `llm.c` outputs
- [ ] Benchmark against baseline C and Python implementations

---

## 🚦 Success Criteria

- Train a GPT-2 small model (or mini version) on `tinyshakespeare.txt`
- Achieve comparable loss/accuracy to `llm.c` on CPU
- Achieve performance speedup using Accelerate over naive Zig loops
- Produce a readable and idiomatic Zig implementation

---

## ✨ Stretch Goals

- Add Metal backend for GPU acceleration
- Support float16 / quantized inference
- Export ONNX-compatible format
- Web UI for inference

---

## 🔚 Final Deliverables

- `zig-llm` open-source repo
- Documentation: setup, usage, API reference
- Blog post or README explaining Zig+Accelerate design choices
- Example models + pre-tokenized dataset
