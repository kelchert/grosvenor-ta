# grosvenor-ta — next session pickup

First state file created 2026-06-06 (security remediation, pre-onboarding).

## Last session (2026-06-06)
- DONE: profiles RLS remediated. Anon could read all PII (names/apts/emails) and
  insert arbitrary rows; both closed. SELECT now TO authenticated USING(true),
  anon INSERT policy dropped (signup uses the SECURITY DEFINER handle_new_user()
  trigger, so it was pure attack surface). Applied live + first tracked supabase
  migration (20260606114108). Verified: anon SELECT -> [], anon INSERT -> 42501,
  Security Advisor profiles/always-true lints -> 0.
- PUSH PENDING: 2 commits on main not yet pushed to origin (8d5b76c, 2985d16).

- ~/Developer/grosvenor-ta-private/ exists (plain dir, not a repo). Holds the
  relocated tenants CSV (resident names × apartments), moved out of the repo
  because netlify.toml has publish=".", so anything under the repo root is
  publishable. Holding pen pending the deliberate SCOPE conversion: flip publish
  to an allowlist dir; once the served root is allowlisted, in-repo-but-unpublished
  becomes safe and this dir either folds back in or becomes the GTA-ops split. Do
  not delete or fold back before that.
- OPEN: RLS confirmation on the OTHER tables. profiles is now locked, but this
  session only audited profiles. chat / bulletin / announcements / direct_messages
  policies are unaudited — same anon-key check (curl + Security Advisor) should be
  run against each. The 0e8c9739 / Kenneth / Joseph rows are real residents.
- DECIDED 2026-06-06: "Hide my email" stays frontend-only; DB-level enforcement
  consciously declined. Rationale: threat is tenant-to-tenant (a logged-in resident
  hand-querying the API), not public — the anon hole was the real exposure and is
  closed. For a single building this is an accepted residual, not a gap to fix.
  Revisit only if scale or a specific incident changes the calculus. The fix if ever
  needed: a directory view that omits email when show_in_directory is off.
- NOTED (pre-existing, not urgent): rejectUser() (community.html:2038) calls .delete()
  on profiles but there's no DELETE policy, so it silently no-ops. Admin reject
  doesn't actually remove the row. Separate fix when convenient.
