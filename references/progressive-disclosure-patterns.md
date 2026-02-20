# Progressive Disclosure Patterns

Guide for organizing skill content using progressive disclosure principles.

---

## The Three-Level Loading System

Skills use a hierarchical loading system to manage context efficiently:

| Level | Content | When Loaded | Size |
|-------|---------|-------------|------|
| **Level 1** | Metadata (name + description) | Always in context | ~100 words |
| **Level 2** | SKILL.md body | When skill triggers | Keep <500 lines |
| **Level 3** | References/Assets/Scripts | Only when explicitly needed | Varies |

### Key Insight

> **The description in YAML frontmatter is the ONLY trigger mechanism.**
> 
> Body content loads AFTER the skill triggers, so "When to Use" sections in the body are useless for activation.

---

## SKILL.md Size Constraints

### Hard Limits

- **Maximum 500 lines** in SKILL.md
- **Maximum 10,000 words** in any single reference file
- **Reference files >100 lines** need table of contents

### Why These Limits?

Context window is a shared resource. Skills compete with:
- System prompt
- Conversation history
- Other skills' metadata
- User request

**Default assumption: The agent is already very smart.** Only add context it doesn't already have.

---

## Organizing References/

### Pattern 1: High-Level Guide with References

Keep SKILL.md lean, link to details:

```markdown
# Skill Name

## Quick Start
[Immediate actions]

## Advanced Features
- **Complex Topic**: See [ADVANCED.md](references/ADVANCED.md)
- **API Details**: See [API.md](references/API.md)
- **Examples**: See [EXAMPLES.md](references/EXAMPLES.md)
```

**When to use:** Single skill with multiple complexity levels

---

### Pattern 2: Domain-Specific Organization

Organize by business/domain area:

```
skill-name/
├── SKILL.md (overview)
└── references/
    ├── finance.md
    ├── sales.md
    ├── product.md
    └── marketing.md
```

**When to use:** Skill serves multiple teams/domains

**Example:**
```markdown
# Data Analytics Skill

## Domain Selection
- **Finance metrics**: See [references/finance.md](references/finance.md)
- **Sales pipeline**: See [references/sales.md](references/sales.md)
- **Product analytics**: See [references/product.md](references/product.md)
```

---

### Pattern 3: Framework/Variant Organization

Organize by technology/framework:

```
skill-name/
├── SKILL.md (workflow + selection guide)
└── references/
    ├── react.md
    ├── vue.md
    ├── svelte.md
    └── angular.md
```

**When to use:** Skill supports multiple frameworks/stacks

---

### Pattern 4: Conditional Details

Show basic, link to advanced:

```markdown
# Document Processing

## Basic Usage
Use default settings for standard documents.

**For tracked changes**: See [REDLINING.md](references/REDLINING.md)
**For custom formatting**: See [FORMATTING.md](references/FORMATTING.md)
```

**When to use:** Most users need basics, some need advanced features

---

## Reference File Structure

### Table of Contents (Required for >100 lines)

```markdown
# Reference Name

## Table of Contents
- [Section 1](#section-1)
- [Section 2](#section-2)
- [Section 3](#section-3)

---

## Section 1
...

## Section 2
...

## Section 3
...
```

### Frontmatter for References (Optional but helpful)

```yaml
---
type: reference
domain: finance
complexity: advanced
prerequisites: [basic-accounting, sql-basics]
---
```

---

## Assets/ vs References/ Distinction

| Directory | Loaded into Context? | Purpose | Examples |
|-----------|---------------------|---------|----------|
| **references/** | ✅ Yes, when needed | Documentation to inform decisions | API docs, schemas, patterns |
| **assets/** | ❌ No | Files used in output | Templates, images, fonts |
| **scripts/** | ⚠️ Sometimes | Executable code | Python/Bash scripts |

### Key Rule

> **Assets are copied to output. References are read for knowledge.**

---

## Anti-Patterns to Avoid

### ❌ Duplicate Information

Don't put the same info in both SKILL.md and references/:

```markdown
# ❌ Bad: Duplicate content
## Advanced Features (in SKILL.md)
Detailed explanation of advanced features...
[500 lines of details]

# Also in references/advanced.md
Detailed explanation of advanced features...
[same 500 lines]
```

### ✅ Better

```markdown
# ✅ Good: Single source
## Advanced Features
For advanced usage patterns, see [references/advanced.md](references/advanced.md)
```

---

### ❌ Deeply Nested References

```
# ❌ Bad: Nested references
references/
├── advanced/
│   └── deep/
│       └── nested/
│           └── file.md
```

### ✅ Better

```
# ✅ Good: Flat structure
references/
├── advanced.md
├── deep-topics.md
├── nested-concepts.md
```

**Rule:** All reference files should link directly from SKILL.md

---

### ❌ "When to Use" in Body

```markdown
# ❌ Bad: Triggers in body (too late!)
---
name: my-skill
description: "A helpful skill"
---

# When to Use This Skill
Use when: (1) X happens, (2) Y happens...
```

### ✅ Better

```yaml
# ✅ Good: Triggers in frontmatter (activates skill!)
---
name: my-skill
description: |
  Helpful skill for specific tasks.
  
  Use when:
  (1) X condition occurs
  (2) Y condition occurs
  (3) Z condition occurs
---
```

---

## Writing Effective Triggers

### Trigger Formula

```
[Brief description]. Use when: (1) [Specific condition], (2) [Specific condition], ...
```

### Good Examples

```yaml
description: |
  Comprehensive document creation and editing.
  Use when: (1) Creating new documents, (2) Modifying content, 
  (3) Working with tracked changes, (4) Adding comments
```

```yaml
description: |
  React component development with TypeScript.
  Use when: (1) Building React components, (2) Adding TypeScript types,
  (3) Managing component state, (4) Handling events
```

### Bad Examples

```yaml
# ❌ Too vague
description: "A skill for coding"

# ❌ No trigger phrases
description: "This skill helps with various tasks"

# ❌ Only features, no conditions
description: "Supports React, Vue, and Angular"
```

---

## Quick Reference Checklist

### Creating a New Skill

- [ ] Description contains "Use when" with numbered conditions
- [ ] SKILL.md <500 lines
- [ ] References/ organized by Pattern 1, 2, 3, or 4
- [ ] No duplicate info between SKILL.md and references/
- [ ] Reference files >100 lines have table of contents
- [ ] Assets/ separated from references/
- [ ] Scripts/ for deterministic operations only

### Reviewing an Existing Skill

- [ ] Can I remove this section without losing trigger capability?
- [ ] Is this information needed for EVERY use of the skill?
- [ ] Could this be moved to references/ and loaded on demand?
- [ ] Are there duplicate explanations anywhere?

---

## Example: Complete Skill Structure

```
my-skill/
├── SKILL.md (45 lines)
├── references/
│   ├── advanced.md (120 lines + TOC)
│   ├── troubleshooting.md (80 lines)
│   └── api-reference.md (250 lines + TOC)
├── assets/
│   ├── templates/
│   │   └── starter-template.tsx
│   └── styles/
│       └── theme.css
└── scripts/
    └── validate-input.py
```

### SKILL.md (Level 1 + 2)

```yaml
---
name: my-skill
description: |
  Short, clear description of what this does.
  Use when: (1) Condition A, (2) Condition B, (3) Condition C
---

# My Skill

## Quick Start
- Action 1
- Action 2

## Core Workflow
1. Step one
2. Step two

## Advanced Topics
See [references/advanced.md](references/advanced.md)

## Troubleshooting
See [references/troubleshooting.md](references/troubleshooting.md)
```

---

## Summary

1. **Triggers live ONLY in frontmatter description**
2. **SKILL.md stays under 500 lines**
3. **Split by domain, framework, or complexity**
4. **Never duplicate information**
5. **Assets ≠ References (different purposes)**
6. **Flat reference structure (no deep nesting)**
