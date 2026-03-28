# Build Sequence

Methodology for Section 8 of the PRD. Answers the question engineering can't easily derive from a flat story list: "Where do we start, and what ships in what order?"

Grounded in three engineering frameworks. These are included so engineering teams recognize the thinking — this isn't product overstepping into architecture, it's product doing the sequencing work that only product can do.

## Conceptual Foundations

**Walking Skeleton** (Alistair Cockburn) — The first build increment should be the thinnest possible end-to-end path that proves the architecture connects. Not the most valuable feature — the one that validates the plumbing. Everything after adds meat to the skeleton. If Slice 1 doesn't work, nothing built on top of it will.

**Tracer Bullets** (Hunt & Thomas, The Pragmatic Programmer) — Each subsequent slice fires a thin round through every integration layer. You can see where it hits. If it hits wrong, you adjust aim before firing more rounds. The alternative — building one entire layer before touching the next — means you don't discover integration failures until the end.

**Integration Contracts** (DDD-adjacent) — The durable decisions product can specify are the ones at system boundaries — where changing them requires coordination across teams or systems. Everything inside a boundary is engineering's call.

## What Product Specifies vs. What Engineering Specifies

This boundary matters. The Build Sequence section stays in product's lane.

**Product specifies (Build Sequence section):**
- Integration boundaries — product-level constraints that are genuinely durable
- Ordered vertical slices — what capability ships in what order, with story traceability
- Acceptance criteria — product-level definition of "this slice works" (not test cases)

**Engineering specifies (NOT in the Build Sequence):**
- How to build each slice internally (which layer first, file structure, refactoring strategy)
- Specific APIs, endpoints, data structures, class names, function names
- Internal test structure and coverage approach
- Build/deploy strategy within a slice
- Database migration sequencing

If the Build Sequence section names a function, a file, or an internal API — it's overstepping. If it names a data entity, a permission boundary, or an integration point — it's doing its job.

## Part 1: Integration Boundaries

Product-level constraints that are genuinely durable because changing them has high coordination cost. Four categories:

### Data Entities and Ownership
What data entities does this feature introduce or depend on? Who owns them? This is not a schema design — it's a statement of what data exists and who is the source of truth.

**Good:** "This feature depends on the User Profile entity (owned by the Auth service) and introduces a Notification Preference entity (owned by this PRD). Notification Preference reads from User Profile but never writes back to it."

**Bad:** "Create a `notification_preferences` table with columns `id`, `user_id`, `channel`, `enabled_at`." ← This is schema design. Engineering's job.

### Permission Boundaries
Who can see or do what at system boundaries? Where do permission checks live in the product model?

**Good:** "Reports are visible to any user with the Reporting permission. Individual-level data is gated behind a separate Detail Access toggle that team leads control. Organization admins see aggregated data only — no individual-level drill-down."

**Bad:** "Add a `canViewAnalytics()` middleware check before the `/api/analytics` route." ← Implementation detail.

### System Seams
Where does this feature connect to external systems, other product surfaces, or third-party services?

**Good:** "This feature reads from the third-party payment processor webhook (external), writes to the reporting dashboard (internal surface), and surfaces config in the admin settings panel (internal surface). The payment processor is the system of record for transaction data — this feature never modifies it."

**Bad:** "Use the Stripe webhook at `/webhooks/stripe` to listen for `payment_intent.succeeded` events." ← API-level detail.

### Critical State Transitions
What meaningful state changes does this feature introduce? What triggers each transition? These are product-level state machines, not technical ones.

**Good:** "A report generation request moves through three states: Queued (waiting for processing), Ready (report is generated and available), Expired (underlying data has changed, regeneration needed). The system automatically transitions from Ready to Expired when source data is updated."

**Bad:** "Use a state machine library with transitions defined in the Report model." ← Implementation detail.

## Part 2: Vertical Slices

An ordered sequence of thin, complete end-to-end increments. Each slice delivers a narrow but complete path through every integration layer — not a horizontal layer of one system.

### Slice Format

Each slice contains:

**Name** — Descriptive, not "Phase 1." The name should tell an engineer what they'll be able to demo when this slice ships.

**Stories covered** — By number, referencing the User Stories section. Every story in the PRD must appear in exactly one slice.

**What's demoable** — One sentence describing what a stakeholder can see or verify when this slice ships.

**Dependencies** — Which prior slices must be complete. Slice 1 has no dependencies.

**Acceptance criteria** — Product-level criteria that prove the slice works. Not test cases — observable behaviors.

### Example

```
**Slice 1: Activity Feed with Live Data (Walking Skeleton)**
Stories: 1-8
Demoable: User opens the dashboard, sees a live activity feed with real data from the source system.
Dependencies: None
Acceptance criteria:
- Activity feed displays the 20 most recent events with timestamp, actor, and action
- Events reflect actual source data (not mocked)
- Feed updates when date range filter changes
- Empty state displays when no events exist for the selected range
```

### Sequencing Strategies

Claude recommends a strategy based on context. Owner can override.

**Risk-first** — Build the hardest or most uncertain integration first. If it fails, you find out early before investing in dependent features. Default for features with uncertain architecture or unfamiliar integrations.

**Value-first** — Build the most valuable user-facing capability first. Gets stakeholder feedback on the highest-impact piece as early as possible. Default for features with well-understood architecture where the risk is low.

**Dependency-first** — Build prerequisites before dependents. Follow the dependency chain from the component map. Default when the feature has deep dependency chains where nothing works until the foundation exists.

**Hybrid** — Often the right answer is a combination: Slice 1 is the walking skeleton (risk-first to prove architecture), Slices 2-3 are value-first (most impactful capabilities), remaining slices follow dependency order.

### The Walking Skeleton Rule

Slice 1 should always be a walking skeleton — the narrowest possible path through all integration layers that produces a working, demoable result. Even if it's not the most impressive feature.

The walking skeleton proves:
- Data flows from source to display
- Permission checks work at system boundaries
- Integration seams connect
- The end-to-end architecture holds

If the walking skeleton fails, you've discovered it before building 10 slices on top of a broken foundation. If it succeeds, every subsequent slice has a proven architecture to build on.

### Anti-Patterns

**Horizontal slices** — "Slice 1: all database work. Slice 2: all API work. Slice 3: all UI work." Nothing is demoable until Slice 3. Integration failures hide until the end.

**Non-demoable slices** — "This slice sets up the infrastructure." If a stakeholder can't see or verify something when the slice ships, it's not a real increment. Fold infrastructure into the first slice that needs it.

**Slices without story traceability** — "Phase 1: foundation and setup." Which stories does this cover? If none, it's not a product increment — it's engineering scaffolding that should be invisible to the PRD.

**Over-specified internals** — "Use a Redux store with slices for each metric domain, and a custom hook for data fetching." This is engineering's call. The PRD says what's demoable, not how to wire it.

**Slice 1 is the biggest slice** — If Slice 1 covers 40% of the stories, it's not thin enough. The walking skeleton should be the minimum viable path, not the minimum viable product.

## Quality Check

Before finalizing the Build Sequence section, verify:

- [ ] Every user story appears in exactly one slice (no orphans, no duplicates)
- [ ] Every slice is independently demoable
- [ ] Slice 1 is a walking skeleton (thinnest end-to-end path)
- [ ] Dependencies between slices are explicit and acyclic
- [ ] Integration boundaries describe entities and ownership, not schema
- [ ] Permission boundaries describe roles and access, not middleware
- [ ] System seams describe connections, not API details
- [ ] No file names, function names, or implementation details appear anywhere
- [ ] Acceptance criteria are observable behaviors, not test cases
