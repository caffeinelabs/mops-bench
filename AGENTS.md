# AGENTS.md

Motoko benchmarking library (Mops package `bench`) that runs benchmark code and produces a markdown table of instructions and heap usage.

## Layout

- `src/lib.mo` — the library's public API.
- `test/lib.test.mo` — test/benchmark entry run by `mops test`.
- `example/` — a self-contained sample package with its own `mops.toml`; run its benchmark from inside this directory.

## Toolchain

- This is a [Mops](https://mops.one) package; install the `mops` CLI to work with it.
- Pinned toolchain (`mops.toml` `[toolchain]`): `moc = "1.0.0"`, `wasmtime = "40.0.0"`.
- Running benchmarks requires `dfx` (CI pins version `0.30.1`); `mops bench` starts a local dfx replica.
- Ensure `moc` is available before testing: `mops toolchain bin moc || mops toolchain use moc latest`.

## Build / test

- Run tests: `mops test` (from the repository root).
- Run the example benchmark: `mops bench` from within `example/`.

## Conventions

- Benchmark files live in `bench/*.bench.mo` and must export `module { public func init() : Bench.Bench { ... } }`.
- Dependencies used only in benchmarks belong in the `[dev-dependencies]` section of `mops.toml`.
- `.mops/` is generated (git-ignored); never hand-edit it.
- The library depends on `core` (2.0.0); it was migrated off `base`.

## CI

The pull-request workflow (`.github/workflows/pull_request_build.yml`) installs `dfx`, runs `mops test`, then runs `mops bench` in `example/`. Keep both passing.
