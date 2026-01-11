# GTA Website Source File Management

## The Problem
When you download files from the live Netlify site, they've already been processed:
- Emails get obfuscated (even with netlify.toml, old files stay broken)
- JavaScript can get minified
- This creates a cycle of re-fixing the same issues

## The Solution: Keep Local Source Files

### Folder Structure
```
GTA-Website/
├── SOURCE/           ← AUTHORITATIVE - edit these only
│   ├── index.html
│   ├── community.html
│   └── netlify.toml
├── assets/
│   ├── building-cropped.jpg
│   └── flyers/
└── README.md
```

### Rules
1. **Never overwrite SOURCE files with downloads from the live site**
2. **All edits happen to SOURCE files**
3. **Deploy by uploading from SOURCE folder**
4. **If you need to check the live site, view it in browser — don't download**

### Deployment Checklist
- [ ] Edits made to SOURCE/index.html (not a downloaded copy)
- [ ] Verify emails show as `mailto:` not `email-protection`
- [ ] netlify.toml included in deploy
- [ ] After deploy, spot-check that emails display correctly

### Quick Validation
Search the source file for these — if found, it's contaminated:
- `email-protection`
- `__cf_email__`
- `data-cfemail`
- `cdn-cgi`

### Recovery
If source gets contaminated, decode emails using:
```python
def decode_cf(encoded):
    key = int(encoded[:2], 16)
    return ''.join(chr(int(encoded[i:i+2], 16) ^ key) for i in range(2, len(encoded), 2))
```
