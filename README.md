# 🔧 Skill Enhancer

An OpenClaw agent skill that elevates skills created with `skill-creator` to production quality.

![Skill Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## ⚠️ Extension of skill-creator

**This skill does NOT create skills from scratch.** It enhances skills after they've been created with `skill-creator`.

```
skill-creator (scaffolds) → skill-enhancer (enhances) → Production-ready skill
```

## What This Skill Does

Transforms basic skills into well-structured, discoverable production skills.

### Key Features

- **🎯 Trigger Optimization** — "Use when..." patterns for better agent routing
- **📚 Progressive Disclosure** — Split large content into `references/`
- **📏 Size Validation** — Keep SKILL.md under 500 lines
- **✅ Best Practice Compliance** — Validate against skills.sh patterns

## Installation

```bash
# Clone to your OpenClaw skills directory
git clone https://github.com/masalale/skill-enhancer.git ~/.openclaw/skills/skill-enhancer
```

## Usage

**Prerequisite:** First create a skill with `skill-creator`:

```bash
clawhub run skill-creator my-skill
```

Then say any of these to enhance it:
- "Enhance my my-skill skill"
- "Optimize this skill"
- "Improve skill triggers"
- "Validate skill"

## What It Enhances

| Before (skill-creator) | After (skill-enhancer) |
|------------------------|----------------------|
| Weak description | "Use when..." triggers |
| 600-line SKILL.md | 180 lines + references/ |
| Flat structure | Progressive disclosure |

## Example

### Before

```yaml
---
name: pdf-processor
description: "A skill for working with PDFs"
---

[600 lines of mixed content...]
```

### After

```yaml
---
name: pdf-processor
description: "PDF processing. Use when: (1) Creating PDFs, (2) Extracting text, (3) Merging..."
---

[Core workflow only - 180 lines]

## References
- API details: `references/api.md`
- Examples: `references/examples.md`
```

## License

MIT — Use freely, credit appreciated.
