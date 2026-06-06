# grosvenor-ta — Grosvenor Tenants Association: website, posters, resident comms

## Session start (read first)
git pull the ~/Developer/deepalignment-docs clone; read docs/START_HERE.md,
docs/DOC_ARCHITECTURE.md, docs/COLLABORATION.md (Kenn relays this in),
docs/SESSION_RITUAL.md (run it), and PLACEMENT_REGISTRY.md (the [GTA] row).
Read this repo's docs/ state files: docs/next_session.md — it carries rolling state,
prior decisions, AND the durable parked/owed-items list. Read it before proposing work.
Precedence: the repo is canonical; no panel copy overrides on-disk.
Pull before reading; pull before push.
Triggers: "run the session open ritual" / "run the session close ritual."

## GTA-specific mechanics (preserved from prior workflow — do not flatten)
- Git/website ops ALWAYS via CC. Never Terminal walkthroughs, GitHub web, or manual
  Netlify drag-and-drop. All disk writes + git ops route through CC.
- Pre-deploy verification (any website change): index.html ends with </html> and
  contains no "email-protection" or "cdn-cgi" strings (the Cloudflare-injection check).
  Run before any deploy.
- Calendar workflow: events on GTA Events (grosvenorta@gmail.com) at event time;
  Penthouse Reservations gets a parallel entry 30 min earlier for setup. Before any
  reschedule/cancel, sweep the full affected month on BOTH calendars — resident
  bookings (bridal showers etc.) live there too.
- Tenant comms: BCC broadcasts (no reply-all chains); withhold descriptive details on
  found items so owners self-verify; keep responses short, factual, maintenance-framed.
- Posters alternate primary color by month (teal odd / orange even); "Tenants
  Association Meeting" spelled out in full on posters.

## Data boundary (the no-duplication rule)
Services are systems of record: Google Calendar owns events, Supabase owns the resident
directory + messaging, Gmail owns comms history. This repo holds source, tooling, and
docs ABOUT those services — never an exported snapshot of their state. Resident-PII
flat-files live permanently OUTSIDE this repo (~/Developer/grosvenor-ta-private/) —
git history is forever.

## Seat-side note (not a CC trigger)
GTA has a claude.ai-seat "status" check-in. It is a SEAT behavior driven by the panel
instructions — the seat answers it, CC does not. Listed here so a CC session doesn't
mistake it for a missing CC command and try to implement it.

## Owed / parked work
Not enumerated here — the durable list lives in docs/next_session.md (single home, so it
can't drift against a second copy). Categories currently parked: the allowlist publish-dir
conversion + public/ reorg; re-homing parked reference docs to docs/; versioning the
poster pipeline; the handle_new_user advisor hardening + leaked-password toggle. See
next_session.md for the live, current list.
