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
