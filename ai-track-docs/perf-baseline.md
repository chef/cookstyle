# Performance Baseline — `Cookstyle.config`

Recorded: 2026-05-26
Ruby: see `Gemfile` / `.ruby-version`
Machine: macOS (Apple Silicon), local dev laptop

## Method Under Test

`Cookstyle.config` — resolves the active YAML config path via
`Dir.exist?`, `File.exist?`, and `File.realpath`.

## Benchmark Setup

Located in `spec/cookstyle_spec.rb`. Calls `Cookstyle.config` 1 000 times
in a tight loop using `Benchmark.realtime`, then derives per-call median.

## Baseline Numbers

| Run | Median (ms/call) | Total (ms) | Iterations |
|-----|-------------------|-----------|------------|
| 1   | 0.0079            | 7.88      | 1 000      |
| 2   | 0.0080            | 8.01      | 1 000      |
| 3   | 0.0080            | 7.97      | 1 000      |
| 4   | 0.0079            | 7.92      | 1 000      |

**Median per call: ~0.008 ms (8 µs)**

## Variance Notes

- Results are extremely stable across runs (< 2 % spread).
- The method is pure filesystem metadata (stat + realpath); no I/O reads.
- Cold-start (first call after process launch) may be ~2× slower due to
  kernel dentry-cache misses, but this is not observable at n = 1 000.
- CI containers or spinning disks may show higher absolute numbers but
  should still be well under the 5 ms guard in the spec.

## Regression Guard

The spec asserts `median < 5.0 ms` — roughly 600× headroom over the
observed baseline. This generous ceiling avoids flaky failures on slow CI
while still catching catastrophic regressions (e.g. accidentally reading
the YAML file on every call).
