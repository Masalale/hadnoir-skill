# Proposed Quality Enforcement Features

> **Status:** Stashed for later consideration  
> **Date:** 2026-02-21  
> **Source:** Discussion with Chomba Clarence

These features were proposed to enforce the skills.sh research patterns but were set aside pending further evaluation of whether strict enforcement aligns with the research intent.

---

## Proposed Features

### 1. Strict Validation Mode

```bash
~/.config/hadnoir-skill/enhance-skill.sh my-skill --strict
```

**Purpose:** Fail if critical quality rules are broken.

**Checks:**
- SKILL.md > 500 lines
- No "Use when" in description
- Duplicate content between files
- Broken reference links

**Research Alignment:** Directly enforces the size limits and trigger requirements from skills.sh research.

---

### 2. Pre-Commit Hook

```bash
# Auto-installs to ~/.openclaw/skills/.git/hooks/pre-commit
hadnoir-skill install-hook
```

**Purpose:** Block commits of skills that fail validation.

**Research Alignment:** Neutral — automation mechanism not covered in research.

---

### 3. Quality Report (Lint)

```bash
hadnoir-skill lint my-skill
```

**Example Output:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
my-skill Quality Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Triggers     ✓ "Use when" found (4 conditions)
Size         ✓ 312 lines (limit: 500)
References   ✓ All links resolve
Assets       ⚠ Empty scripts/ folder

Score: 85/100
```

**Research Alignment:** Visualizes compliance with research patterns.

---

### 4. Auto-Fix Mode

```bash
hadnoir-skill lint my-skill --fix
```

**What it would do:**
- Move long sections to references/
- Add missing "Use when" template
- Remove duplicate content

**Research Alignment:** ⚠️ RISKY — The research says move "detailed" content to references, but determining what's "essential" vs "detailed" requires **judgment**. Auto-fix might move wrong things.

---

## Implementation Concerns

The core tension:

| Aspect | Risk |
|--------|------|
| **Structure** | Research clearly defines optimal structure (3-tier loading, size limits) |
| **Judgment** | What's "essential" vs "detailed" is contextual |
| **Automation** | Strict enforcement might distort intent |

**Key Question:** Does enforcing structure enhance quality, or does it risk creating rigid, poorly-organized skills that technically pass checks but miss the spirit of progressive disclosure?

---

## Recommendation

Before implementing:
1. Test current `enhance-skill.sh` on real skills
2. Observe where judgment vs automation is needed
3. Decide if enforcement adds value or friction

---

## Reference

- Original research: `references/progressive-disclosure-patterns.md`
- Source skills.sh research: `https://skills.sh/anthropics/skills/skill-creator`
