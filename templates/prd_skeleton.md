# [Product Name] — [Surface/Feature] — Product Requirements Document

**Status:** v1 — draft, pending adversarial review. Target audience: [audience].
**Last Updated:** [YYYY-MM-DD]
**Author:** [author]
**Depends on:** [list of related docs with filenames]

---

## 1. Problem Statement

<!-- What gap exists, from the user's perspective. 2-3 paragraphs max. No solution details — just the pain point, who feels it, and why it matters. -->

## 2. Solution

<!-- How the product solves it. High-level architecture, role model, navigation model, scope boundaries. An engineer should understand the shape of the system from this section alone. -->

## 3. User Stories

<!-- Exhaustive numbered list, grouped by domain/surface area. -->
<!-- Format: "As an [actor], I want [feature], so that [benefit]." -->
<!-- Include system stories: "As the system, I want to..." -->
<!-- Number continuously across groups. -->

### [Domain/Surface A]

1. As a [actor], I want [feature], so that [benefit].

### [Domain/Surface B]

2. As a [actor], I want [feature], so that [benefit].

## 4. Implementation Decisions

<!-- Architectural decisions, data model choices, interaction patterns, schema requirements, integration points. -->
<!-- No code snippets or file paths. Durable decisions only. -->
<!-- Every decision should be traceable to a user story or edge case. -->

## 5. Out of Scope

### Explicitly Out of Scope

<!-- Features considered and intentionally excluded or deferred. Include rationale for each. -->

### V2 Candidates

<!-- Features informed by V1 telemetry that may be added later. Reference where deferred items are tracked. -->

## 6. Cross-PRD Dependencies

### From Other PRDs (This PRD Consumes)

| Source Document | What This PRD Needs |
|----------------|-------------------|
| [filename] | [specific data, config, or behavior consumed] |

### To Other PRDs (This PRD Provides)

| Consuming Document | What This PRD Provides |
|-------------------|----------------------|
| [filename] | [specific data, config, or behavior provided] |

## 7. Companion Documents

| Document | Filename | Purpose |
|----------|----------|---------|
| Process Ledger | [prd_filename]_process_ledger.md | Reasoning trail: ecosystem snapshot, decision log with rationale, stress test alternatives, adversarial findings, reconciliation results |
| Reconciliation Pass | [prd_filename]_reconciliation_pass.md | Detailed verification record from system validation (Phase 9) |
| [name] | [filename] | [what this doc provides in context of this PRD] |

## 8. Build Sequence

<!-- See references/build_sequence.md for methodology. -->
<!-- Product specifies: integration boundaries + ordered vertical slices. -->
<!-- Product does NOT specify: file names, internal APIs, layer order within slices, test structure. -->

### Integration Boundaries

<!-- Four categories of product-level constraints: -->
<!-- 1. Data entities and ownership — what data exists, who is source of truth -->
<!-- 2. Permission boundaries — who can see/do what at system boundaries -->
<!-- 3. System seams — where this feature connects to external systems or other surfaces -->
<!-- 4. Critical state transitions — meaningful state changes and their triggers -->

### Vertical Slices

<!-- Ordered sequence of demoable increments. Slice 1 is always a walking skeleton. -->

**Slice 1: [Name] (Walking Skeleton)**
Stories: [numbers]
Demoable: [one sentence — what a stakeholder can see/verify]
Dependencies: None
Acceptance criteria:
- [observable behavior]

**Slice 2: [Name]**
Stories: [numbers]
Demoable: [one sentence]
Dependencies: Slice 1
Acceptance criteria:
- [observable behavior]
