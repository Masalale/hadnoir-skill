# Framework Patterns for Skill Building

Reference guide for building skills that target React/Next.js.

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

### Key Files to Include

| File | Purpose |
|------|---------|
| `skill-client.ts` | Typed client for external API |
| `use-skill.ts` | React hook for skill state/logic |
| `schema.ts` | Zod validation schemas |
| `types.ts` | Shared TypeScript interfaces |
| `actions.ts` | Next.js Server Actions (optional) |

### Common Pitfalls

- **Hydration Mismatch**: Always use `useEffect` for client-only data
  ```tsx
  const [mounted, setMounted] = useState(false);
  useEffect(() => setMounted(true), []);
  if (!mounted) return null;
  ```

- **Server vs Client Components**: Mark client components with `'use client'`
  - Default: Server Component
  - Need hooks/interactivity: Add `'use client'`
  - Fetching data: Server Component (preferred)

- **Async Server Actions**: Must be async functions, not arrow functions in some cases
  ```ts
  // ✅ Correct
  export async function myAction() { }
  
  // ❌ Avoid
  export const myAction = async () => { }
  ```

### Best Practices

1. **Use React Query/TanStack Query** for server state management
2. **Zod for validation** on both client and server
3. **Co-locate related files** (component + test + styles)
4. **Prefer Server Components** for data fetching
5. **Use ` Suspense` boundaries** for loading states
6. **Export named hooks** not just components

---

## Cross-Framework Guidelines

### Skill Configuration Pattern

All skills should accept a configuration object:

```ts
interface SkillConfig {
  apiKey?: string;
  baseUrl?: string;
  timeout?: number;
  debug?: boolean;
}

// Validation
const configSchema = z.object({
  apiKey: z.string().optional(),
  baseUrl: z.string().url().default('https://api.example.com'),
  timeout: z.number().min(1000).default(30000),
  debug: z.boolean().default(false),
});
```

### Error Handling Pattern

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

// Usage
throw new SkillError('API request failed', 'API_ERROR', { status: 500 });
```

### Export Convention

```ts
// index.ts - Public API
export { SkillClient } from './skill-client';
export { useSkill } from './hooks/use-skill';
export type { SkillConfig, SkillResult } from './types';
export { default as SkillWidget } from './components/SkillWidget';
```
