# 🔧 Hadnoir Skill Enhancer

An OpenClaw agent skill that elevates skills created with `skill-creator` to production quality using research-backed patterns from skills.sh and Vercel's best practices.

![Skill Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## ⚠️ Extension of skill-creator

**This skill does NOT create skills from scratch.** It is a **post-processor** that enhances skills after they've been created with OpenClaw's `skill-creator`.

### Workflow

```
skill-creator (scaffolds) → hadnoir-skill (enhances) → Production-ready skill
```

## What This Skill Does

Transforms basic skills into well-structured, discoverable, and maintainable production skills. While `skill-creator` gets you started, this skill makes your skills **award-worthy**.

### Key Features

- **🎯 Trigger Optimization** — "Use when..." patterns for better agent routing
- **📚 Progressive Disclosure** — Split large content into `references/`
- **📏 Size Validation** — Keep SKILL.md under 500 lines
- **✅ Best Practice Compliance** — Validate against skills.sh patterns
- **🔍 Auto-Analysis** — Agent reads and improves without manual work

## Installation

```bash
# Clone to your OpenClaw skills directory
git clone https://github.com/masalale/hadnoir-skill.git ~/.openclaw/skills/hadnoir-skill

# Or use clawhub (when published)
clawhub install hadnoir-skill
```

## Usage

**Prerequisite:** You must first create a skill with `skill-creator`.

```bash
# Step 1: Create base skill with skill-creator
clawhub run skill-creator my-skill

# Step 2: Enhance it with hadnoir-skill
```

Then say any of these to activate enhancement:
- "Enhance my my-skill skill"
- "Optimize this skill"
- "Improve skill triggers"
- "Add references structure"
- "Validate skill"
- "Skill review"
- "Make skill better"

### The Enhancement Process

When you ask, the agent automatically:

1. **Reads** your skill's SKILL.md
2. **Analyzes** against best practices
3. **Optimizes** frontmatter with clear triggers
4. **Splits** large content to `references/`
5. **Validates** structure and size
6. **Reports** what was improved

**No manual scripts. No complex steps.**

## Skill Architecture

```
~/.openclaw/skills/hadnoir-skill/
├── SKILL.md                        # Agent instructions (this skill)
├── enhance-skill.sh                # Helper script (agent uses sparingly)
├── templates/
│   └── SKILL.md.enhanced           # Optimized template
└── references/
    └── progressive-disclosure-patterns.md
```

**Total: ~15KB of enhancement intelligence**

## Comparison: Before vs After

| Aspect | skill-creator Output | After hadnoir-skill |
|--------|---------------------|---------------------|
| **Description** | "A skill for working with PDFs" | "PDF processing. Use when: (1) Creating PDFs, (2) Extracting text, (3) Merging..." |
| **SKILL.md size** | 600 lines (everything inline) | 180 lines + references/ |
| **Structure** | Flat | Progressive disclosure |
| **Triggers** | Weak | Clear "Use when..." patterns |
| **Validation** | None | Best practice compliance |

## Example Enhancement

### Before (skill-creator output)

```yaml
---
name: pdf-processor
description: "A skill for working with PDFs"
---

# PDF Processor

[600 lines of mixed content...]
```

### After (hadnoir-skill enhancement)

```yaml
---
name: pdf-processor
description: "PDF processing and manipulation. Use when: (1) Creating or editing PDFs, (2) Extracting text from PDFs, (3) Merging or splitting PDFs, (4) Converting PDFs to other formats"
---

# PDF Processor

## Quick Start
[Core workflow only - 180 lines]

## References
- API details: `references/api.md`
- Examples: `references/examples.md`
- Troubleshooting: `references/troubleshooting.md`
```

## Philosophy

### The Enhancement Principles

1. **Clear Triggers** — Agents must know WHEN to use the skill
2. **Progressive Disclosure** — Load details only when needed
3. **Size Discipline** — Keep SKILL.md lean, move rest to references/
4. **Validation** — Check against proven patterns

### What Gets Enhanced

| Element | Enhancement |
|---------|-------------|
| **Frontmatter** | Add "Use when..." trigger phrases |
| **SKILL.md** | Reduce to core workflow (<500 lines) |
| **references/** | Create and populate with split content |
| **Structure** | Add scripts/, assets/ if needed |
| **Validation** | Check size, triggers, organization |

## When to Use This Skill

### ✅ Use After
- Running `clawhub run skill-creator my-skill`
- Creating a new skill manually
- Noticing poor agent routing
- SKILL.md growing beyond 300 lines

### ❌ Don't Use For
- Creating skills from scratch (use `skill-creator`)
- Writing skill content (you do that)
- Testing skills (use `clawhub run`)

## Relationship to skill-creator

| | skill-creator | hadnoir-skill |
|---|---|---|
| **Purpose** | Scaffold skills from scratch | Enhance existing skills |
| **When** | Starting new skill | After creation, before finalizing |
| **Who does work** | You guide, agent scaffolds | You ask, agent enhances |
| **Input** | Your requirements | Existing skill folder |
| **Output** | New skill directory | Optimized skill |

**They work together.** skill-creator gets you 70% there. hadnoir-skill gets you to 100%.

## References

This skill draws from:
- [skills.sh](https://skills.sh) best practices
- [Vercel Agent Skills](https://github.com/vercel-labs/agent-skills) - Reference implementation
- OpenClaw skill-creator - Base scaffolding tool

## License

MIT — Use freely, credit appreciated.

---

**"Make skills discoverable, usable, and maintainable."**
