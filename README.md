# hadnoir-skill

An OpenClaw agent skill that enhances other skills using research-backed patterns from skills.sh and Vercel's best practices.

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## What's This?

A post-processing **agent skill** that optimizes skills created with `skill-creator`. Instead of you manually running scripts, the **agent does the work** using this skill's guidance.

### The Problem It Solves

Skills created with `skill-creator` often:
- ❌ Have weak trigger descriptions
- ❌ Put everything in SKILL.md (too long)
- ❌ Lack progressive disclosure structure
- ❌ Don't validate against best practices

This skill fixes those issues **automatically**.

## Installation

```bash
# Clone to your OpenClaw skills directory
git clone https://github.com/masalale/hadnoir-skill.git ~/.openclaw/skills/hadnoir-skill
```

## Usage (Agent-Driven)

**You say:**
> "Enhance my pdf-processor skill"

**The agent does:**
1. Reads your `pdf-processor/SKILL.md`
2. Analyzes it against best practices
3. Optimizes frontmatter with clear triggers
4. Splits large content to `references/`
5. Validates the structure
6. Reports what was improved

**No manual scripts. No complex steps. Just ask.**

### Triggers

Say any of these to activate:
- "Enhance this skill"
- "Optimize my skill"
- "Improve skill triggers"
- "Add references structure"
- "Validate skill"
- "Skill review"
- "Make skill better"

## What It Enhances

| Before | After |
|--------|-------|
| Weak description | "Use when..." triggers |
| 600-line SKILL.md | 180-line SKILL.md + references/ |
| All content inline | Progressive disclosure |
| No validation | Best practice compliance |
| Poor agent routing | Clear trigger optimization |

## Example

### Before Enhancement

```yaml
---
name: pdf-processor
description: "A skill for working with PDFs"
---

# PDF Processor

[600 lines of everything...]
```

### After Enhancement

```yaml
---
name: pdf-processor
description: "PDF processing and manipulation. Use when: (1) Creating or editing PDFs, (2) Extracting text, (3) Merging/splitting, (4) Converting formats"
---

# PDF Processor

## Quick Start
[Core workflow only - 180 lines]

## References
- API details: `references/api.md`
- Examples: `references/examples.md`
```

## How It Works

```
You: "Enhance my skill"
    ↓
Agent (using hadnoir-skill):
    1. Read SKILL.md
    2. Analyze structure
    3. Apply patterns
    4. Optimize frontmatter
    5. Split to references/
    6. Validate
    7. Report changes
    ↓
You: "Thanks!"
```

## Structure

```
~/.openclaw/skills/hadnoir-skill/
├── SKILL.md                        # Agent instructions (this skill)
├── enhance-skill.sh                # Helper script (agent uses sparingly)
├── templates/
│   └── SKILL.md.enhanced           # Optimized template
└── references/
    └── progressive-disclosure-patterns.md
```

## Comparison: skill-creator vs hadnoir-skill

| | skill-creator | hadnoir-skill |
|---|---|---|
| **Purpose** | Create skills from scratch | Enhance existing skills |
| **When to use** | Starting new skill | After skill-creator, before finalizing |
| **Who does work** | You guide, agent creates | You ask, agent enhances |
| **Input** | Your requirements | Existing skill folder |
| **Output** | New skill directory | Optimized skill |

## Workflow

```bash
# Step 1: Create base skill (agent does this)
clawhub run skill-creator my-skill

# Step 2: Enhance it (agent does this when you ask)
"Enhance my my-skill skill"

# Done!
```

## References

- [skills.sh](https://skills.sh) - Agent skills ecosystem
- [Vercel Agent Skills](https://github.com/vercel-labs/agent-skills) - Reference implementation
- OpenClaw skill-creator - Base scaffolding tool

## License

MIT - Use freely, credit appreciated.

---

**"Let the agent do the hard work."**
