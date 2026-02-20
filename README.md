# hadnoir-skill

Personal skill enhancement toolkit based on research into progressive disclosure and trigger optimization.

## What's This?

A post-processing enhancer for skills created with OpenClaw's `skill-creator`. Applies research-backed patterns for:
- Trigger-optimized SKILL.md frontmatter
- Progressive disclosure structure
- Framework-specific references
- Validation checks

## Installation

```bash
# Clone to your config directory
git clone https://github.com/YOUR_USERNAME/hadnoir-skill.git ~/.config/hadnoir-skill
```

## Usage

```bash
# 1. Create a skill with base tool
clawhub run skill-creator my-skill

# 2. Enhance with research patterns
~/.config/hadnoir-skill/enhance-skill.sh my-skill
```

## What It Adds

| Feature | Description |
|---------|-------------|
| **Trigger Optimization** | SKILL.md with "Use when..." patterns |
| **Size Validation** | Ensures SKILL.md <500 lines |
| **Progressive Disclosure** | Proper references/ structure |
| **Framework Guides** | React, Astro, Svelte, Vanilla JS patterns |
| **Starter Templates** | Pre-built reference files |

## Structure

```
~/.config/hadnoir-skill/
├── enhance-skill.sh              # Main script
├── templates/
│   └── SKILL.md.enhanced         # Optimized template
└── references/
    ├── progressive-disclosure-patterns.md
    └── framework-patterns.md
```

## References

- [Skills.sh](https://skills.sh) - Agent skills ecosystem
- [Vercel Agent Skills](https://github.com/vercel-labs/agent-skills) - Reference implementation
- OpenClaw skill-creator - Base scaffolding tool

## License

MIT - Use for your own skill development.
