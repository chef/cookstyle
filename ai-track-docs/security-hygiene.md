# Security Hygiene Notes

Recorded: 2026-05-26

---

## Audit Summary

A scan of the repository found **no hardcoded secrets**. All matches for
`api_key`, `secret`, `password`, `token`, `private_key` are either:

- Cop definitions that *detect* secrets in user cookbooks (e.g.
  `Chef/Security/SshPrivateKey`)
- Example code in docs/cop descriptions (e.g. `basic_auth_password = secure_password`)
- GitHub Actions `${{ secrets.GITHUB_TOKEN }}` — a standard, non-hardcoded
  platform-provided token

No `.env`, `.pem`, `.key`, `.p12`, `.pfx`, or credential files exist on disk.

---

## .gitignore Improvements (applied)

The following patterns were added to `.gitignore` to prevent accidental
commits of secret material:

```gitignore
.env
.env.*
*.pem
*.key
*.p12
*.pfx
*.jks
**/credentials.yml
**/secrets.yml
**/secret_token.rb
**/*.credential
**/*.keystore
```

These cover the most common secret file types across Ruby, Java/Habitat,
and general development workflows.

---

## Existing Safeguards

| Control | Status |
|---------|--------|
| `.gitignore` secret patterns | **Added** (this change) |
| `Chef/Security/SshPrivateKey` cop | Present — detects SSH private keys in cookbooks |
| CI uses `${{ secrets.* }}` only | Verified — no inline tokens in workflow files |
| No vendor-bundled secrets | Verified — `vendor/` is gitignored |
| `Gemfile.lock` is gitignored | Yes — prevents leaking dependency resolver metadata |

---

## Recommendations

1. **Add `bundler-audit`** to the dev Gemfile and CI pipeline to catch
   known CVEs in resolved gems:
   ```bash
   gem install bundler-audit
   bundle audit check --update
   ```

2. **Consider a pre-commit hook** (e.g. via [`pre-commit`](https://pre-commit.com/)
   or [`overcommit`](https://github.com/sds/overcommit)) that runs
   `detect-secrets` or `gitleaks` to block commits containing secret
   patterns.

3. **GitHub push protection** — if not already enabled, turn on
   [Secret scanning](https://docs.github.com/en/code-security/secret-scanning)
   and push protection on the `chef/cookstyle` repository.

4. **Rotate immediately** if any secret is ever found in git history.
   Use `git filter-repo` (not `filter-branch`) to rewrite history and
   revoke the exposed credential.

---

## Files Reviewed

- `.gitignore` — updated
- `.github/workflows/ci-main-pull-request-stub-1.0.8.yml` — clean
- `config/cookstyle.yml` — cop definitions only
- `lib/rubocop/cop/chef/correctness/openssl_password_helpers.rb` — example code only
- All `*.rb`, `*.yml`, `*.json`, `*.sh` files — scanned via regex
