# Framework Patterns for Skill Building

Reference guide for building skills that target specific JavaScript frameworks.

---

## React / Next.js

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

## Astro

### Recommended Directory Structure

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
│   │       └── skill.ts      # API routes
│   └── layouts/
│       └── SkillLayout.astro
├── db/
│   └── seed.ts               # Drizzle/ORM setup
├── actions/
│   └── index.ts              # Astro Actions
├── config.ts                 # Skill configuration
└── index.ts                  # Public exports
```

### Key Files to Include

| File | Purpose |
|------|---------|
| `skill-client.ts` | Isomorphic client (works server + client) |
| `config.ts` | Runtime config with Zod validation |
| `actions/index.ts` | Astro Actions for mutations |
| `db/schema.ts` | Database schema (if using Drizzle) |

### Common Pitfalls

- **Client Directives**: Must specify when component hydrates
  ```astro
  <!-- Loads immediately -->
  <SkillWidget client:load />
  
  <!-- Loads when visible -->
  <SkillWidget client:visible />
  
  <!-- Only on media query match -->
  <SkillWidget client:media="(min-width: 768px)" />
  ```

- **Top-level await**: Astro components support top-level await
  ```astro
  ---
  const data = await fetchSkillData(); // ✅ Works!
  ---
  ```

- **Import paths**: Use `~/` alias for src directory
  ```ts
  import { client } from '~/lib/skill-client';
  ```

### Best Practices

1. **Zero-JS by default** - Only hydrate what needs interactivity
2. **Use Astro Actions** for form submissions and mutations
3. **Content Collections** for structured content (YAML/JSON/Markdown)
4. **Server islands** for personalized content without full hydration
5. **Hybrid rendering** - Configure per-route:
   ```ts
   export const prerender = false; // Server-rendered
   export const prerender = true;  // Static at build
   ```

---

## Svelte / SvelteKit

### Recommended Directory Structure

```
skill-name/
├── src/
│   ├── lib/
│   │   ├── components/
│   │   │   ├── SkillWidget.svelte
│   │   │   └── SkillCard.svelte
│   │   ├── skill-client.ts
│   │   ├── skill-store.ts      # Svelte stores
│   │   └── types.ts
│   ├── routes/
│   │   ├── api/
│   │   │   └── skill/
│   │   │       └── +server.ts  # API endpoint
│   │   └── +page.svelte        # Skill page
│   └── app.html
├── src/lib/index.ts            # Public exports
└── svelte.config.js
```

### Key Files to Include

| File | Purpose |
|------|---------|
| `skill-client.ts` | API client with fetch |
| `skill-store.ts` | Writable/readable stores |
| `types.ts` | TypeScript definitions |
| `+page.server.ts` | Server load function |
| `+page.ts` | Universal load function |

### Common Pitfalls

- **Store subscriptions**: Auto-subscribe in templates, manual in JS
  ```svelte
  <!-- Auto-subscribed -->
  <p>{$skillStore.name}</p>
  
  <!-- Manual in script -->
  <script>
    import { get } from 'svelte/store';
    const value = get(skillStore); // One-time read
  </script>
  ```

- **Form actions**: Use `enhance` for progressive enhancement
  ```svelte
  <form method="POST" use:enhance>
    <!-- Form fields -->
  </form>
  ```

- **Reactive statements**: Use `$:` for derived values
  ```svelte
  <script>
    let count = 0;
    $: doubled = count * 2; // Re-runs when count changes
  </script>
  ```

### Best Practices

1. **Use SvelteKit's form actions** with `use:enhance`
2. **Stores for global state** - Keep it simple
3. **Page data streaming** with `+page.ts` load functions
4. **Handle client-side navigation** with `beforeNavigate`
5. **Server-side rendering** by default, opt-in to CSR

---

## Vanilla JS

### Recommended Directory Structure

```
skill-name/
├── src/
│   ├── skill.js              # Main entry point
│   ├── skill-client.js       # API client
│   ├── skill-ui.js           # DOM manipulation
│   ├── skill-state.js        # State management
│   └── types.d.ts            # Type definitions (optional)
├── dist/
│   └── skill.bundle.js       # Built output
├── index.html                # Demo/test page
├── skill.css                 # Component styles
└── package.json
```

### Key Files to Include

| File | Purpose |
|------|---------|
| `skill.js` | Main entry, initializes skill |
| `skill-client.js` | Fetch wrapper with error handling |
| `skill-state.js` | Lightweight state management |
| `skill-ui.js` | DOM helpers and rendering |
| `types.d.ts` | JSDoc + TypeScript definitions |

### Common Pitfalls

- **Event delegation**: Use for dynamic elements
  ```js
  // ✅ Good - works for dynamically added items
  container.addEventListener('click', (e) => {
    if (e.target.matches('.skill-button')) {
      handleClick(e);
    }
  });
  ```

- **Memory leaks**: Always clean up event listeners
  ```js
  const controller = new AbortController();
  element.addEventListener('click', handler, { signal: controller.signal });
  
  // Cleanup
  controller.abort();
  ```

- **Async/await error handling**:
  ```js
  // ✅ Proper error handling
  async function fetchData() {
    try {
      const res = await fetch('/api/data');
      if (!res.ok) throw new Error(res.statusText);
      return await res.json();
    } catch (err) {
      console.error('Fetch failed:', err);
      throw err;
    }
  }
  ```

### Best Practices

1. **Use ES modules** - `type: "module"` in package.json
2. **Build with Vite/Rollup** for production bundles
3. **JSDoc for types** - Good IntelliSense without TypeScript
4. **CSS custom properties** for theming
5. **Web Components** if framework-agnostic encapsulation needed
6. **Feature detection** over user agent sniffing
   ```js
   if ('geolocation' in navigator) { }
   ```

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

---

## Choosing a Framework

| Scenario | Recommendation |
|----------|----------------|
| Dashboard/admin UI | Next.js + React |
| Content-heavy site | Astro |
| Interactive SPA | SvelteKit |
| Embed in existing site | Vanilla JS |
| Minimal bundle size | Astro or Vanilla |
| Team already knows React | Next.js |
| Rapid prototyping | SvelteKit |
| Library/SDK for multiple frameworks | Vanilla JS core + framework wrappers |
