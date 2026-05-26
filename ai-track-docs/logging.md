# Logging Guide — Cookstyle Module

Recorded: 2026-05-26

---

## Overview

Structured logging is available on the `Cookstyle.config` code path.
It is **off by default** (zero overhead) and activated via the
`COOKSTYLE_LOG` environment variable.

---

## Enabling Logs

### Log to stderr

```bash
COOKSTYLE_LOG=stderr bundle exec cookstyle .
```

### Log to a file

```bash
COOKSTYLE_LOG=/tmp/cookstyle.log bundle exec cookstyle .
cat /tmp/cookstyle.log
```

### Disable (default)

Unset the variable or leave it empty — no logger is created, no
runtime cost.

---

## Log Format

Each line is an ISO-8601 UTC timestamp followed by a JSON object:

```
2026-05-26T12:00:00.123Z {"op":"config","status":"ok","elapsed_ms":0.042,"config":"/path/to/config/default.yml"}
```

### Consistent Fields

| Field | Type | Description |
|-------|------|-------------|
| `op` | string | Operation name (e.g. `"config"`) |
| `status` | string | `"ok"` on success, `"error"` on failure |
| `elapsed_ms` | float | Wall-clock time for the operation in milliseconds |

### Extra Fields (vary by op/status)

| Field | When | Description |
|-------|------|-------------|
| `config` | `status=ok` | Resolved config file path |
| `reason` | `status=error` | Human-readable error description |
| `path` | `status=error` (file) | Path that was not found |
| `config_dir` | `status=error` (dir) | CONFIG_DIR that was not found |

---

## Example Output

**Success:**
```
2026-05-26T12:00:00.123Z {"op":"config","status":"ok","elapsed_ms":0.038,"config":"/Users/dev/cookstyle/config/default.yml"}
```

**Error (missing file):**
```
2026-05-26T12:00:00.456Z {"op":"config","status":"error","elapsed_ms":0.012,"path":"/Users/dev/cookstyle/config/nonexistent.yml","reason":"config file not found"}
```

---

## Filtering Logs

Since output is JSON, pipe through `jq` for structured queries:

```bash
# Show only errors
COOKSTYLE_LOG=/tmp/cookstyle.log bundle exec cookstyle .
cat /tmp/cookstyle.log | sed 's/^[^ ]* //' | jq 'select(.status == "error")'

# Show elapsed times
cat /tmp/cookstyle.log | sed 's/^[^ ]* //' | jq '{op, elapsed_ms}'
```

---

## Implementation Details

- Logger is built once via `Cookstyle.logger` (memoized in `@logger`).
- Timing uses `Process.clock_gettime(CLOCK_MONOTONIC)` for accurate,
  monotonic measurement unaffected by system clock changes.
- `log_event` is a private class method that short-circuits immediately
  when `logger` is nil.
- Tests inject a `StringIO`-backed logger to capture and parse output
  without touching `ENV` or the filesystem.

## Resilience: Graceful Degradation on Log Errors

`build_logger` catches `SystemCallError` (covers `Errno::ENOENT`,
`Errno::EACCES`, `Errno::EISDIR`, etc.) when opening the log file.
Instead of crashing, it:

1. Prints a warning to stderr: `[cookstyle] Could not open log destination '...': ...`
2. Returns `nil`, so the rest of Cookstyle runs normally without logging.

This means a misconfigured `COOKSTYLE_LOG` path never prevents linting.

**Before:** `COOKSTYLE_LOG=/bad/path bundle exec cookstyle` → crash with
`Errno::ENOENT`.

**After:** warns once, continues linting without logging.

**Tests:** Two failure-mode specs in `spec/cookstyle_spec.rb`:
- Invalid path (`/no/such/dir/cookstyle.log`) → returns nil, warns
- Not-writable path (`/dev/null/impossible.log`) → returns nil, warns

---

## Adding Logging to New Code Paths

Use the same pattern:

```ruby
def self.some_method
  t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  # ... work ...
  log_event(t0, 'operation_name', 'ok', key: value)
end
```

Always include `op`, `status`, and let `log_event` compute `elapsed_ms`.

---

## Debug Toggle (`COOKSTYLE_DEBUG`)

A lightweight toggle that prints a one-line boot diagnostic to stderr.
Separate from structured logging — designed for quick "is it loading the
right config?" checks.

### Enable

```bash
COOKSTYLE_DEBUG=1 bundle exec cookstyle .
```

Output (stderr):

```
[cookstyle debug] v8.7.0 (rubocop 1.86.1) config=/path/to/config/default.yml ruby=3.1.7
```

### Disable (default)

Unset `COOKSTYLE_DEBUG` or leave it empty. No output, no overhead.

### How it works

- `Cookstyle.debug?` returns `true` when `ENV['COOKSTYLE_DEBUG']` is
  non-empty, `false` otherwise.
- `emit_debug` (private) writes to `$stderr` only on the success path
  of `.config`. Error paths rely on the exception message instead.
- Can be combined with `COOKSTYLE_LOG` — they are independent.

### Tests

Four specs in `spec/cookstyle_spec.rb` under `.debug? toggle`:

| Test | Mode | Asserts |
|------|------|---------|
| `returns false when not set` | OFF | `debug?` is `false` |
| `returns true when set` | ON | `debug?` is `true` |
| `prints diagnostics when ON` | ON | stderr matches `[cookstyle debug] v...` |
| `prints nothing when OFF` | OFF | stderr is empty |

