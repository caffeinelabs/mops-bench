# AGENTS.md

A Mops package providing a benchmarking library for Motoko code, run via `mops bench`.

## Build, test, and run

This is a [Mops](https://mops.one) package. Install the Mops CLI before running any command.

- Run the unit tests: `mops test` (from the repository root).
- Run the bundled example benchmark: `cd example && mops bench`.

Running benchmarks requires `dfx` (the DFINITY SDK), since `mops bench` starts a local replica.

## Pinned tool versions

- Motoko compiler (`moc`): `1.0.0` — pinned in `mops.toml` under `[toolchain]`.
- `wasmtime`: `40.0.0` — pinned in `mops.toml`.
- CI uses `dfx` `0.30.1` and Node.js `22`.

If `moc` is missing, install it with `mops toolchain use moc latest`.

## Layout

- `src/` — the library source (`lib.mo`).
- `test/` — unit tests (`*.test.mo`).
- `example/` — a self-contained example package with its own `mops.toml`; its benchmark lives under `example/bench/`.

Benchmark files are `*.bench.mo` and each must export an `init()` returning a `Bench.Bench` (see `README.md`).

## Conventions

- `.mops/` is the dependency cache (gitignored); never edit or commit it.
- Benchmark-only dependencies belong in the `[dev-dependencies]` section of `mops.toml`.
- CI (`.github/workflows/pull_request_build.yml`) runs `mops test` and the example `mops bench` on pull requests; both must pass.
