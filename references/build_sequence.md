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

## Part 0: Prerequisites

External dependencies that must exist before Slice 1 begins. These are not things the PRD builds — they are infrastructure, services, or other PRD slices that must already be in place.

Categories:
- **Infrastructure** — hosting, DNS, auth services, email delivery, payment platforms
- **Data dependencies** — data models or pipelines from other PRDs that must be persisted and queryable
- **Cross-PRD slices** — specific slices from other PRDs that must be complete (e.g., "AdvisorLounge Slice 3 must be complete for the store entity to exist")
- **External confirmations** — decisions from engineering that gate specific features (e.g., "CA to confirm feasibility of field X before Slice N")

List each prerequisite with: what it is, which slice first needs it, and any notes on timing or risk.

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

**Unlocks** — Which downstream slices (in this PRD or other PRDs) can begin once this slice is complete. This is the inverse of Dependencies — it tells engineers what they're unblocking. Format: '[PRD Name] Slice N (what it enables)'. If nothing is unlocked, say 'None (final slice)' or 'None directly.'

**Acceptance criteria** — Product-level criteria that prove the slice works. Not test cases — observable behaviors.

**Done criteria** — Pass/fail engineering test checklist. Every item is a checkbox that's either green or not. Distinct from acceptance criteria: acceptance criteria describe product behaviors, done criteria describe specific tests an engineer writes and runs. Every done criterion must be:
- **Testable** — an automated or manual test can verify it
- **Pass/fail** — no subjective judgment, no 'renders correctly'
- **Edge-case-aware** — cover error states, empty states, permission boundaries, not just happy paths
- **Data-contract-complete** — if this slice produces data consumed by another slice, include a criterion verifying the data is available via the expected interface

Done criteria are what define 'done done done' — when every box is checked, the slice is landed and downstream work can begin.

### Example

```
**Slice 1: Activity Feed with Live Data (Walking Skeleton)**
Stories: 1-8
Demoable: User opens the dashboard, sees a live activity feed with real data from the source system.
Dependencies: None
Unlocks: Slices 2-5 (all depend on the pipeline this slice proves). ExternalApp Slice 3 (feed data available for aggregation).
Acceptance criteria:
- Activity feed displays the 20 most recent events with timestamp, actor, and action
- Events reflect actual source data (not mocked)
- Feed updates when date range filter changes
- Empty state displays when no events exist for the selected range
Done criteria:
- [ ] Feed renders 20 most recent events within 30 seconds of page load
- [ ] Creating a new event in the source system: event appears in feed within the refresh cycle
- [ ] Date range filter: changing range updates displayed events without page reload
- [ ] Zero events for selected range: empty state renders with guidance text
- [ ] Feed data available via API for downstream consumers (ExternalApp)
- [ ] Invalid date range (start after end): clear error message, no crash
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

## Multi-PRD Build Orchestration

When a product has multiple PRDs with cross-dependencies, each PRD gets its own Build Sequence AND a master orchestration document sits alongside them.

### When to Create an Orchestration Doc

Create a Build Orchestration Plan when:
- Two or more PRDs have cross-PRD dependencies (one PRD's slice depends on another PRD's slice)
- Engineering needs to understand parallelization across PRDs (what can be built simultaneously)
- The critical path spans multiple PRDs

### What the Orchestration Doc Contains

**Layer 0: Platform Infrastructure** — shared services and dependencies that must exist before any PRD slice begins. Includes infrastructure (auth, hosting, email), data dependencies (pipelines, data models), reference documents (metric dictionaries, entity models), and external confirmations.

**Cross-PRD Dependency Chain** — visual map showing which slices in which PRDs depend on which slices in other PRDs. Every "Unlocks" and "Dependencies" annotation across all PRDs should be traceable in this map.

**Phased Build Plan** — groups slices from all PRDs into phases based on dependency ordering. Each phase lists: which slices are included, what's unlocked at completion, and parallelization opportunities within the phase. Phases are not calendar sprints — they are dependency gates. Work within a phase can overlap.

**Critical Path Analysis** — identify the longest dependency chain across all PRDs. When multiple candidate paths exist (common), track all of them. The critical path determines minimum build time; everything else can be parallelized around it. Identify highest-risk nodes (slices with the most downstream dependents).

**Schedule Compression Opportunities** — slices whose dependencies are met earlier than their assigned phase. These represent opportunities to pull work forward if resources are available.

### Cross-Cutting Stories

Some stories are enforced in every slice rather than belonging to a single slice (e.g., permission boundaries, data visibility rules). Formally assign these to Slice 1 (where enforcement begins) in the Stories line, and note them as cross-cutting in the acceptance criteria of every subsequent slice.

### Audit Pattern: Double-Blind Validation

After building the orchestration plan and all per-PRD Build Sequences, run a double-blind audit:
1. Launch two independent agents with the same audit scope (story coverage, dependency chains, unlock annotations, done criteria completeness)
2. Compare their findings for convergence and disagreements
3. Launch a third agent to validate the orchestration plan against the actual PRD dependencies (phasing, critical path, parallelization claims)
4. Launch a fourth agent to audit done criteria quality (testability, edge cases, data contracts)
5. Fix all findings, then run a final validation agent to confirm all fixes applied correctly

This pattern catches errors that a single-pass review misses.

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
- [ ] Prerequisites section lists all external dependencies with which slice needs them
- [ ] Every slice has an Unlocks annotation (or explicitly says "None")
- [ ] Every slice has Done criteria that are pass/fail and testable
- [ ] Producer slices have data contract done criteria verifying output availability
- [ ] Cross-cutting stories are formally assigned to Slice 1 and noted in subsequent slices
- [ ] If multi-PRD: orchestration doc exists with phased plan and critical path
- [ ] If multi-PRD: every cross-PRD dependency is bidirectionally annotated (Unlocks on upstream, Dependencies on downstream)
