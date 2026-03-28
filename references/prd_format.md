# PRD Format

Universal structure for product requirements documents. This format produces specs that engineers can build against without follow-up questions.

## Header Block

```
# [Product Name] — [Surface/Feature] — Product Requirements Document

**Status:** v[N] — [status description]. Target audience: [audience].
**Last Updated:** [YYYY-MM-DD]
**Author:** [author]
**Depends on:** [list of related docs with filenames]
```

- Use `**Last Updated:**` not `**Date:**`. Always YYYY-MM-DD format.
- Status tracks the document lifecycle: `v1 — pending adversarial review`, `v2 — post-adversarial, pending system validation`, etc.
- "Depends on" lists every document this PRD reads from or writes to.

## Sections (in order)

Every PRD contains these eight sections, in this order. No section is optional in a finalized PRD.

### 1. Problem Statement
What gap exists, from the user's perspective. 2-3 paragraphs max. No solution details here — just the pain point, who feels it, and why it matters.

### 2. Solution
How the product solves the problem. High-level architecture, role model, navigation model, scope boundaries. Concise but complete enough that an engineer understands the shape before reading details. This is the "30-second briefing" — someone should be able to read this section alone and know what they're building.

### 3. User Stories
Exhaustive numbered list, grouped by domain/surface area. Format: "As an [actor], I want [feature], so that [benefit]."

- Include system stories ("As the system, I want to...")
- Group by logical domain (e.g., Dashboard, Settings, Permissions, Data Model)
- Number continuously across groups (not per-group)
- This is the largest section and the primary reference for QA test case generation

### 4. Implementation Decisions
Architectural decisions, data model choices, interaction patterns, schema requirements, integration points. These are the durable decisions that constrain implementation.

- No code snippets or file paths — those belong in engineering docs
- Every decision should be traceable to a user story or edge case
- If a decision affects another document, note it here

### 5. Out of Scope
What this PRD explicitly does not cover. Split into two subsections:

- **Explicitly Out of Scope** — Features that were considered and intentionally excluded or deferred. Include rationale.
- **V2 Candidates** — Features informed by V1 telemetry that may be added later. Reference where they'd be tracked.

### 6. Cross-PRD Dependencies
Two tables:

**From Other PRDs (This PRD Consumes)**
| Source Document | What This PRD Needs |
|----------------|-------------------|
| [filename] | [specific data, config, or behavior consumed] |

**To Other PRDs (This PRD Provides)**
| Consuming Document | What This PRD Provides |
|-------------------|----------------------|
| [filename] | [specific data, config, or behavior provided] |

Use filenames, not document titles. Be specific about what's consumed/provided — "user data" is too vague; "User Profile entity including `display_name`, `role`, and `last_login` fields" is actionable.

### 7. Companion Documents
Table of related documents with purpose descriptions. Every PRD produced by the gauntlet includes at minimum two companion artifacts:

- **Process Ledger** (`[prd_filename]_process_ledger.md`) — the reasoning trail: ecosystem snapshot, decision log with rationale, stress test alternatives, adversarial findings, reconciliation results. Stored alongside the PRD.
- **Reconciliation Pass** (`[prd_filename]_reconciliation_pass.md`) — the detailed verification record from system validation. Stored alongside the PRD.

These appear first in the companion docs table, followed by any project-specific companion documents.

| Document | Filename | Purpose |
|----------|----------|---------|
| [name] | [filename] | [what this doc provides in context of this PRD] |

### 8. Build Sequence
The recommended build order for engineering. Two parts: Integration Boundaries and Vertical Slices. See `references/build_sequence.md` for full methodology.

**Integration Boundaries** define the product-level constraints engineering must respect — data entities and ownership, permission boundaries, system seams, and critical state transitions. These describe what exists at system boundaries, not how to implement internals.

**Vertical Slices** define the ordered sequence of demoable increments. Each slice is a thin, complete path through every integration layer. Each slice references which user stories it covers, what's demoable when it ships, its dependencies on prior slices, and product-level acceptance criteria.

Slice 1 should always be a walking skeleton — the thinnest end-to-end path that proves the architecture connects. Subsequent slices add capability on top of the proven foundation.

This section does NOT specify: file names, function names, internal APIs, database schema details, test structure, or layer-by-layer build order within a slice. Those are engineering decisions.

## Format Rules

- Dates: YYYY-MM-DD, always
- User stories: numbered continuously, grouped by domain
- Field names: exact match across all documents that reference them
- Config keys: consistent format (typically snake_case)
- Cross-references: use filenames, not assumptions about what exists
