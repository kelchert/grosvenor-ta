# grosvenor-ta — next session pickup

First state file created 2026-06-06 (security remediation, pre-onboarding).

ONBOARDED to portfolio 2026-06-06 — onboarding commit "onboard grosvenor-ta to
portfolio system" (SHA reported to the hub session; a commit can't contain its own
hash, so it's anchored here by date + message rather than a self-referential SHA).
Hub session closed 2026-06-06; GTA stub placed in Panel; onboarding commit ae7854d
on origin. Onboarding loop complete.

## Parked / owed work
Single durable home for owed items — the CLAUDE.md spine points here so this can't
drift against a second copy. Detailed context for several of these already lives in
the dated entries below; this is the index.
- Allowlist publish-dir conversion + public/ reorg. Careful live-site work: flip
  netlify publish from "." to an allowlisted served dir, then reorg. Unblocks folding
  ~/Developer/grosvenor-ta-private/ back in (see holding-pen note below). Not started.
- Re-home parked REFERENCE docs into docs/ — name them so they're not lost: the full
  poster house-style spec, the detailed calendar-workflow reference, and the comms
  playbook (the reference-depth versions). NOTE: the operational guardrails are now
  inline in CLAUDE.md; what's parked is the reference DETAIL. The panel still holds the
  authoritative copies of these specific docs until they're re-homed here.
- Version the poster pipeline (ReportLab scripts + building.jpg) into a
  poster-pipeline/ subtree. Currently un-versioned tooling.
- Fold GTA-SourceFileManagement.md's still-valid parts (the Cloudflare contamination
  check + decode-recovery procedure) into a future docs/deploy.md. The doc stays at
  docs/GTA-SourceFileManagement.md (canonical) until that fold happens.
- Advisor hardening (separate pass, not table-RLS): handle_new_user — set search_path
  + tighten SECURITY DEFINER EXECUTE (3 advisor lints) — and enable leaked-password
  protection. Same item tracked in the dated RLS entries below.

## Session 2026-06-06 (cont.) — remaining-tables RLS audit + chat lockdown
- DONE: chat SELECT restricted to authenticated (was role=public USING(true), i.e.
  world-readable via the public anon key embedded in community.html). Sensitive group
  chat, never shown pre-login (loadChat runs only from showMainApp after auth+approval).
  Migration 20260606080306 applied live + tracked. Verified: anon SELECT chat -> [];
  anon SELECT announcements/bulletin still return rows (confirms not over-locked);
  Security Advisor re-run -> no new lints.
- DECIDED 2026-06-06: announcements + bulletin SELECT stay role=public / anon-readable
  ON PURPOSE — reserved for a future public-facing notices view. This is NOT the
  profiles always-true bug; do not "fix" it. Residual accepted: bulletin is
  resident-authored and its display joins profiles(full_name, apartment), so a
  public-readable bulletin exposes poster name + apartment. Accepted for a building
  noticeboard. Revisit if a privacy concern surfaces.
- CLOSED: the carried-forward "audit remaining tables" item. All 5 public tables are
  now audited — profiles + chat remediated; direct_messages is correctly
  participant-scoped (SELECT USING auth.uid()=sender_id OR recipient_id — a logged-in
  resident cannot read others' DMs) and left alone; announcements + bulletin
  intentionally public (above). No anon INSERT holes on any table (all -> 42501).
- OPEN (separate hardening pass, NOT table-RLS): handle_new_user advisor warnings
  (anon/authenticated SECURITY DEFINER executable + mutable search_path) and the
  leaked-password-protection toggle. Address as its own pass when convenient.

## Last session (2026-06-06)
- DONE: profiles RLS remediated. Anon could read all PII (names/apts/emails) and
  insert arbitrary rows; both closed. SELECT now TO authenticated USING(true),
  anon INSERT policy dropped (signup uses the SECURITY DEFINER handle_new_user()
  trigger, so it was pure attack surface). Applied live + first tracked supabase
  migration (20260606114108). Verified: anon SELECT -> [], anon INSERT -> 42501,
  Security Advisor profiles/always-true lints -> 0.

- ~/Developer/grosvenor-ta-private/ exists (plain dir, not a repo). Holds the
  relocated tenants CSV (resident names × apartments), moved out of the repo
  because netlify.toml has publish=".", so anything under the repo root is
  publishable. Holding pen pending the deliberate SCOPE conversion: flip publish
  to an allowlist dir; once the served root is allowlisted, in-repo-but-unpublished
  becomes safe and this dir either folds back in or becomes the GTA-ops split. Do
  not delete or fold back before that.
- (was OPEN, now CLOSED — see "Session 2026-06-06 (cont.)" above): RLS confirmation
  on the OTHER tables. chat / bulletin / announcements / direct_messages have all
  now been audited via the anon-key check + Security Advisor. The 0e8c9739 / Kenneth
  / Joseph rows are real residents.
- DECIDED 2026-06-06: "Hide my email" stays frontend-only; DB-level enforcement
  consciously declined. Rationale: threat is tenant-to-tenant (a logged-in resident
  hand-querying the API), not public — the anon hole was the real exposure and is
  closed. For a single building this is an accepted residual, not a gap to fix.
  Revisit only if scale or a specific incident changes the calculus. The fix if ever
  needed: a directory view that omits email when show_in_directory is off.
- NOTED (pre-existing, not urgent): rejectUser() (community.html:2038) calls .delete()
  on profiles but there's no DELETE policy, so it silently no-ops. Admin reject
  doesn't actually remove the row. Separate fix when convenient.
