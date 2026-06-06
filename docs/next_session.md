# grosvenor-ta — next session pickup

First state file created 2026-06-06 (security remediation, pre-onboarding).

- ~/Developer/grosvenor-ta-private/ exists (plain dir, not a repo). Holds the
  relocated tenants CSV (resident names × apartments), moved out of the repo
  because netlify.toml has publish=".", so anything under the repo root is
  publishable. Holding pen pending the deliberate SCOPE conversion: flip publish
  to an allowlist dir; once the served root is allowlisted, in-repo-but-unpublished
  becomes safe and this dir either folds back in or becomes the GTA-ops split. Do
  not delete or fold back before that.
- OPEN: tenant-data RLS confirmation (Supabase dashboard) — the actual data lock;
  repo audit can't reach it.
