# GTA Website Handoff — January 11, 2026

## Summary
Major infrastructure upgrade completed: Git + GitHub + Netlify auto-deploy now working. PDF font issues identified but not yet resolved.

---

## Completed Today

### Infrastructure (BIG WIN)
- **Git repository created**: `github.com/kelchert/grosvenor-ta`
- **Netlify connected to GitHub**: Auto-deploys on every `git push`
- **Workflow now**: Edit files in `~/Documents/grosvenor-ta/` → `git add . && git commit -m "message" && git push` → Live in ~30 seconds
- **netlify.toml fixed**: Had duplicate section causing deploy failures

### Website Content Added
- ✅ ButterflyMX card (Building Information section)
- ✅ Keyfob Duplication card - Manhattan Hardware (Building Information section)
- ✅ Community Signup Flyer added to Newsletters archive
- ✅ .gitignore added to exclude .DS_Store files

### Flyer Created
- `GrosvenorCommunitySignupFlyer.pdf` — Teal-accented signup guide with QR code
- Already in `flyers/2026/2026-01-CommunitySignupFlyer.pdf`

---

## Pending Tasks

### 1. Add JoinOurCommunityPoster to Archive
The lobby poster exists at `flyers/2026/2026-01-10-JoinOurCommunityPoster.pdf` but isn't listed in index.html.

**Fix:** Add to Lobby Posters section in index.html:
```html
<li class="archive-item"><a href="flyers/2026/2026-01-10-JoinOurCommunityPoster.pdf" target="_blank">Join Our Community (Sign-Up Poster)</a><span class="archive-date">January 2026</span></li>
```

### 2. Fix Broken PDF Font Rendering
Several PDFs display with overlapping text in Chrome's PDF viewer due to missing embedded fonts.

**Affected files:**
| File | Source Status |
|------|---------------|
| `2025-06-28-WhatsNextLobbyPoster.pdf` | Have .pages file ✅ |
| `2025-05-17-Paddington2LobbyPoster.pdf` | Need to find .pages |
| `2025-04-26-MovieNightVotePoster.pdf` | Need to find .pages |
| `2025-04-17-GameNightLobbyPoster.pdf` | Have good PDF from Google Drive ✅ |

**Solution:** Export from Pages app with embedded fonts:
1. Open .pages file in Pages
2. File → Export To → PDF
3. Save and replace in git folder
4. Push to GitHub

### 3. Source File Locations
- **Mac local**: `/Users/kennethelchert/Documents/Housing/The Grosvenor/Tenants Association`
- **Google Drive**: grosvenorta@gmail.com account
- **Git repo**: `~/Documents/grosvenor-ta/`

---

## Technical Reference

### Git Workflow
```bash
cd ~/Documents/grosvenor-ta
# Make changes to files
git add .
git commit -m "Description of changes"
git push
# Netlify auto-deploys in ~30 seconds
```

### File Structure
```
~/Documents/grosvenor-ta/
├── index.html          # Main site
├── community.html      # Community chat page
├── terms.html          # Terms of service
├── netlify.toml        # Netlify config (email obfuscation disabled)
├── building-cropped.jpg
├── .gitignore
└── flyers/
    ├── 2025/           # Historical flyers
    └── 2026/           # Current year flyers
```

### Netlify Sites
- **Active site**: `admirable-mermaid-d30991` at grosvenorta.com (connected to GitHub)
- **Delete this**: `zesty-biscotti-3e03fd` (orphaned site created during setup)

### Index.html Safeguards
Before deploying, verify:
1. File ends with `</html>` (no truncation)
2. No `email-protection` or `cdn-cgi` strings (Cloudflare obfuscation)

---

## Notes
- Kenn originally created flyers in Apple Pages
- LibreOffice can't properly convert .pages files — must export from Pages app directly
- PDF font issues only affect browser viewing; downloaded PDFs may render correctly in other viewers
- GameNightLobbyPoster PDF from Google Drive is clean and can replace the broken version

---

## Next Session
1. Export .pages files to PDF from Pages app
2. Replace broken PDFs in git folder
3. Add JoinOurCommunityPoster to index.html
4. Push all changes
5. Delete orphaned Netlify site (zesty-biscotti)
