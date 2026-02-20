# Framework Patterns for Skill Building

Reference guide for building skills with modern React frameworks.

---

## React/Next.js

### Recommended Directory Structure

```
skill-name/
├── components/
│   ├── ui/               # Shadcn/ui components
│   ├── widgets/          # Domain-specific components
│   └── shared/           # Reusable across skills
├── hooks/
│   ├── use-skill.ts      # Main skill logic
│   └── use-skill-name.ts # Named export hook
├── lib/
│   ├── skill-client.ts   # API/SDK client
│   ├── types.ts          # TypeScript definitions
│   └── utils.ts          # Framework utilities
├── app/                  # Next.js App Router
│   ├── api/              # Route handlers
│   └── page.tsx          # Skill page/route
├── actions/              # Server Actions
├── schema.ts             # Zod schemas
└── index.ts              # Public API exports
```

### Key Files

| File | Purpose |
|------|---------|
| `skill-client.ts` | Typed API client |
| `use-skill.ts` | React hook for skill logic |
| `schema.ts` | Zod validation |
| `actions.ts` | Next.js Server Actions |

### Common Pitfalls

- **Hydration mismatch**: Use `useEffect` for client-only data
- **Server vs Client**: Mark interactive components with `'use client'`
- **Server Actions**: Use `async function`, not arrow functions

---

## Astro

### Directory Structure

```
skill-name/
├── src/
│   ├── components/
│   │   ├── SkillWidget.astro
│   │   └── SkillCard.astro
│   ├── lib/
│   │   ├── skill-client.ts
│   │   └── types.ts
│   ├── pages/
│   │   └── api/
│   │       └── skill.ts
│   └── layouts/
│       └── SkillLayout.astro
├── actions/
│   └── index.ts          # Astro Actions
└── config.ts
```

### Key Concepts

- **Zero-JS by default**: Only hydrate what needs interactivity
- **Client directives**: `client:load`, `client:visible`, `client:media`
- **Astro Actions**: For form submissions and mutations
- **Content Collections**: For structured YAML/JSON/Markdown

### When to Use

- Content-heavy sites
- Marketing pages
- Documentation
- Blogs

---

## TanStack Start

### Directory Structure

```
skill-name/
├── app/
│   ├── routes/
│   │   ├── __root.tsx
│   │   ├── index.tsx
│   │   └── skill/
│   │       └── index.tsx
│   ├── hooks/
│   │   └── use-skill.ts
│   ├── lib/
│   │   ├── skill-client.ts
│   │   └── server/
│   │       └── skill-actions.ts
│   └── api.ts              # API routes
├── server/
│   └── functions/
│       └── skill-api.ts
└── app.config.ts
```

### Key Concepts

- **File-based routing**: Like Next.js but framework-agnostic
- **Server Functions**: Run server code from client components
- **TanStack Query**: Built-in data fetching
- **Vinxi**: Unified dev server

### When to Use

- Full-stack React without framework lock-in
- Want React Router + TanStack Query together
- Future-proof architecture

---

## React Router v7

### Directory Structure

```
skill-name/
├── app/
│   ├── root.tsx
│   ├── routes.ts           # Route config
│   └── routes/
│       ├── _index.tsx
│       ├── skill/
│       │   ├── _layout.tsx
│       │   └── index.tsx
│       └── api.skill.ts    # Resource route
├── app/hooks/
│   └── use-skill.ts
├── app/lib/
│   └── skill-client.ts
└── react-router.config.ts
```

### Key Concepts

- **Declarative routes**: Define in `routes.ts`
- **Resource routes**: API endpoints without UI
- **Layout routes**: Nested layouts with `_layout.tsx`
- **Client-side navigation**: SPA feel, SSR benefits

### When to Use

- Migrating from React Router v6
- Want control over routing without framework overhead
- Building SPAs with SSR

---

## Remix v3

### Directory Structure

```
skill-name/
├── app/
│   ├── root.tsx
│   ├── routes/
│   │   ├── _index.tsx
│   │   ├── skill.tsx        # Parent route
│   │   └── skill._index.tsx # Child route
│   ├── hooks/
│   │   └── use-skill.ts
│   └── lib/
│       └── skill-client.ts
├── app/routes/api.skill.ts   # Resource route
└── vite.config.ts
```

### Key Concepts

- **Nested routing**: File structure = URL structure
- **Loaders**: Server data for routes
- **Actions**: Form submissions handled server-side
- **Forms**: Progressive enhancement built-in

### When to Use

- Full-stack web apps
- Forms-heavy applications
- Want automatic handling of mutations

---

## Quick Comparison

| Framework | Best For | Learning Curve | Bundle Size |
|-----------|----------|----------------|-------------|
| **Next.js** | Production apps, SEO | Medium | Larger |
| **Astro** | Content sites, speed | Low | Smallest |
| **TanStack Start** | Future-proof React | Medium | Medium |
| **React Router v7** | SPAs, migrations | Low | Medium |
| **Remix v3** | Full-stack, forms | Medium | Medium |

---

## Shared Best Practices

### Error Handling

```ts
class SkillError extends Error {
  constructor(
    message: string,
    public code: string,
    public context?: Record<string, unknown>
  ) {
    super(message);
    this.name = 'SkillError';
  }
}
```

### Config Pattern

```ts
interface SkillConfig {
  apiKey?: string;
  baseUrl?: string;
  timeout?: number;
  debug?: boolean;
}

const configSchema = z.object({
  apiKey: z.string().optional(),
  baseUrl: z.string().url().default('https://api.example.com'),
  timeout: z.number().min(1000).default(30000),
  debug: z.boolean().default(false),
});
```

### Export Convention

```ts
// index.ts
export { SkillClient } from './skill-client';
export { useSkill } from './hooks/use-skill';
export type { SkillConfig, SkillResult } from './types';
export { default as SkillWidget } from './components/SkillWidget';
```
