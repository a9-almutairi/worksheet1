# /README.md
# UFCFWK-15-2 Worksheet 1 – Assembly & Make
This repo contains Task 1–3 solutions using NASM (32-bit) and GCC `-m32`. Build everything with: `make`
```
Run examples:
./build/task1
./build/task1_2
./build/t2_greet
./build/t2_sum100
./build/t2_sum_range
```
## Notes
- Requires `nasm`, `gcc-multilib` (or equivalent) on a 64-bit host.
- Uses `asm_io.asm` / `asm_io.inc` (place them in `src/` as instructed).
- All programs expose `asm_main` and are linked with a shared `driver.c`.
