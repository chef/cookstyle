# Extending the Cookstyle Module

Short guide for developers who need to modify or extend the top-level
`Cookstyle` module (`lib/cookstyle.rb` + `lib/cookstyle/version.rb`).

---

## Module Layout

```
lib/
  cookstyle.rb            # Entry point — config resolution, requires
  cookstyle/
    version.rb            # VERSION and RUBOCOP_VERSION constants
```

### Key constants

| Constant | Defined in | Purpose |
|----------|-----------|---------|
| `VERSION` | `version.rb` | SemVer string for the Cookstyle gem itself |
| `RUBOCOP_VERSION` | `version.rb` | Exact RuboCop version Cookstyle pins at runtime |
| `CONFIG_DIR` | `cookstyle.rb` | Absolute path to the vendored `config/` directory |

### Key methods

| Method | Visibility | Returns |
|--------|-----------|---------|
| `.config` | public | Resolved path to the active YAML config file |
| `.config_file_name` | private | `'default.yml'` or `'chefstyle.yml'` based on mode |

## How Configuration Mode Works

By default Cookstyle loads `config/default.yml`. If you define the constant
`Cookstyle::CHEFSTYLE_CONFIG` **before** `require 'cookstyle'`, it switches
to `config/chefstyle.yml` instead. This is used internally by the `chefstyle`
wrapper gem.

## Common Extension Scenarios

### Bumping the Cookstyle version

Edit `lib/cookstyle/version.rb` and update `VERSION`. No other file
needs changing — the gemspec reads it automatically.

### Upgrading the pinned RuboCop version

1. Update `RUBOCOP_VERSION` in `lib/cookstyle/version.rb`.
2. Run `bundle update rubocop` to refresh the lockfile.
3. Run `bundle exec rake spec` — some cops may need adjustment.

### Adding a new vendored config profile

1. Place the YAML file in `config/`.
2. Add a new constant check in `.config_file_name` (or refactor to a
   lookup table if more than two profiles are needed).
3. Add a test in `spec/cookstyle_spec.rb` covering the new path.

### Adding new monkey patches

Monkey patches live in `lib/rubocop/monkey_patches/`. They are required
explicitly in `cookstyle.rb` **before** the cops are loaded so they take
effect early. Document the reason for each patch inline.

## Testing Strategy

Tests live in `spec/cookstyle_spec.rb`. The strategy is deterministic and
fast (no I/O mocking, no network):

- **Version constants** — regex-match against SemVer format.
- **CONFIG_DIR** — assert it ends with `config` and exists on disk.
- **`.config`** — assert it ends with the expected filename and exists.

Run with:

```bash
bundle exec rspec spec/cookstyle_spec.rb --format documentation
```

Full suite (including all cops):

```bash
bundle exec rake spec
```
