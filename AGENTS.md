# AGENTS.md

A Motoko library (Mops package `bench`) for benchmarking Motoko code with `mops bench`.

## Build, test, and run

This package is managed with [Mops](https://mops.one). Install dependencies with `mops install` before running anything.

- Run the test suite: `mops test` (test sources live in `test/*.test.mo`).
- Run the example benchmarks: `cd example && mops bench`.

Both commands require `dfx` and the `moc` toolchain to be available; `mops bench` starts a local `dfx` replica. If `moc` is missing, install it with `mops toolchain use moc latest`.

## Layout

- `src/` — the library source (`lib.mo`), published as the `bench` package.
- `test/` — Mops tests (`*.test.mo`).
- `example/` — a standalone Mops project demonstrating usage; it has its own `mops.toml` and `bench/*.bench.mo` files.

Benchmark files are named `*.bench.mo` and each must export a `module` with a `public func init() : Bench.Bench`.

## Conventions

- Pinned toolchain versions are declared in `mops.toml` under `[toolchain]` (`moc` and `wasmtime`); keep them in sync when changing.
- CI pins `dfx` to the version set by `dfx_version` in `.github/workflows/pull_request_build.yml`.
- The `.mops` directory holds installed dependencies and is git-ignored; never commit or hand-edit it.
- Bump the version in `mops.toml` and add an entry to `CHANGELOG.md` when releasing.

## CI

`.github/workflows/pull_request_build.yml` runs on pull requests and executes `mops test` and, in `example/`, `mops bench`. Ensure both pass locally before opening a PR.
