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
- DECIDED 2026-06-06: "Hide my email" stays frontend-only; DB-level enforcement
  consciously declined. Rationale: threat is tenant-to-tenant (a logged-in resident
  hand-querying the API), not public — the anon hole was the real exposure and is
  closed. For a single building this is an accepted residual, not a gap to fix.
  Revisit only if scale or a specific incident changes the calculus. The fix if ever
  needed: a directory view that omits email when show_in_directory is off.
- NOTED (pre-existing, not urgent): rejectUser() (community.html:2038) calls .delete()
  on profiles but there's no DELETE policy, so it silently no-ops. Admin reject
  doesn't actually remove the row. Separate fix when convenient.
