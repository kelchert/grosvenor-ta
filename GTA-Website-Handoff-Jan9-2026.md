# Grosvenor TA Website Project — Handoff Document
**Date:** January 9, 2026  
**Prepared for:** Continuation in new Claude conversation

---

## Project Overview

Building a community website for the Grosvenor Tenants Association (82-77 116th Street, Richmond Hill, NY). The site serves 55 units and includes building info, tenant resources, event calendar, community features, and an archive of past communications.

**Live Site:** https://grosvenorta.netlify.app (Netlify, $9/month restored)

---

## Current State

### ✅ Completed
- Full website with building info, tenant resources, emergency contacts
- Google Calendar integration (events auto-display on homepage)
- Community signup with Supabase backend (RLS fixed)
- Profile editing, directory display, phone formatting
- Birthday automation Edge Function (adds to Google Calendar)
- Archive section reorganized into 📰 Newsletters and 🪧 Lobby Posters
- Admin Guide created (GrosvenorCommunityAdminGuide.docx)
- February 2025 "New TA" poster converted to PDF and archived

### 🔧 Needs Deployment
These files in `/mnt/user-data/outputs/` need to be uploaded to Netlify:
- `index.html` — main site with archive updates
- `community.html` — profile/settings features  
- `netlify.toml` — prevents email obfuscation
- `2025-02-NewTALobbyPoster.pdf` → upload to `flyers/2025/`
- `HappyNewYear2026_GameNightFixed.pdf` → replace `flyers/2026/2026-01-HappyNewYear.pdf`

### 🚨 Priority Fix Needed
**Game Night Date Error:**
- Currently shows: Friday, January 16, 2026
- Should be: **Thursday, January 15, 2026**
- Fix in Google Calendar (manual) — website will auto-update
- Corrected poster created: `HappyNewYear2026_GameNightFixed.pdf`

---

## Pending Tasks

### Immediate
- [ ] Fix Game Night in Google Calendar (Fri Jan 16 → Thu Jan 15)
- [ ] Deploy corrected Happy New Year poster
- [ ] Deploy latest index.html, community.html, netlify.toml
- [ ] Upload Admin Guide to GTA Google Drive

### Website Content Updates
- [x] ✅ Revise TA description language on Welcome section — DONE
  - Changed "better place to live" → "great place to live"
  - Added "Who are its members?" section explaining automatic membership
  - Emphasizes participation without pressure
  - Implemented in index.html (needs deployment)

### Other Pending
- [ ] Delete test birthday from Google Calendar
- [ ] Delete Google service account JSON key from Downloads folder
- [ ] Delete Supabase profile for re-signup testing
- [ ] Print and distribute community announcement circular
- [ ] Jan 10 meeting: demo community features to residents
- [ ] Review "A Fresh Start" letter (March 8, 2025, .pages format) for archive
- [ ] Add 2025 historical events to Google Calendar

---

## Welcome Section Language — IMPLEMENTED

**Final version (now in index.html):**

> *The Grosvenor Tenants Association is a community of neighbors working together to make our building a great place to live.*
>
> ***Who are its members?** You are — every lease-holding resident of The Grosvenor is already a member, whether you've attended a single meeting or not. You don't need to sign up or do anything. You're in.*
>
> *But we thrive with your participation, whether highly visible or behind the scenes. Want roofdeck furniture? Let's figure it out together. Think the building or community could be better in some way? There's probably a way to do it. Let's talk it through and see where we align. We're neighbors — finding common ground shouldn't be hard.*
>
> *This site is your hub for building information, resources, and ways to connect with fellow tenants.*

---

## Key Files & Locations

### In `/mnt/user-data/outputs/`
| File | Purpose |
|------|---------|
| `index.html` | Main website |
| `community.html` | Community/signup page |
| `netlify.toml` | Deployment config |
| `GrosvenorCommunityAdminGuide.docx` | Admin instructions |
| `HappyNewYear2026_GameNightFixed.pdf` | Corrected poster (Jan 15) |
| `2025-02-NewTALobbyPoster.pdf` | Feb 2025 archive item |
| `flyers/` | Organized poster/newsletter archive |

### External
- **Google Calendar:** grosvenorta@gmail.com (events) + separate birthday calendar
- **Supabase:** Community profiles database
- **Netlify:** Hosting

### Transcripts (for reference)
- `/mnt/transcripts/2026-01-07-00-55-27-website-deployment-events-styling-birthday-automation.txt`
- `/mnt/transcripts/2026-01-07-17-12-19-website-deployment-birthday-automation-admin-guide.txt`
- `/mnt/transcripts/2026-01-07-17-19-08-game-night-poster-date-fix.txt`

---

## Technical Notes

- **File truncation issue:** Long sessions cause incremental edits to truncate files. Solution: rebuild from scratch when multiple edits accumulate, verify before deployment.
- **Birthday automation:** Edge Function deployed to Supabase, triggers on profile insert, creates yellow events on grosvenorta@gmail.com calendar via Google Calendar API.
- **Events display:** JavaScript fetches from Google Calendar API, displays with bold titles and spacing between cards.

---

## User Files to Review
- **A Fresh Start letter** (March 8, 2025) — uploaded as .pages, needs conversion and archive placement

---

## Context for New Conversation

Kenn is the administrator of the Grosvenor Tenants Association. The Jan 10 meeting is tomorrow — he'll be demoing the community features to residents. The website is functional but needs the deployment items above pushed live. The TA language revision is a content/tone improvement, not urgent but important for how the organization presents itself.

The core message: This isn't a formal organization you join — you're already a member by living here. Participation is welcome but not required. We figure things out together as neighbors.
