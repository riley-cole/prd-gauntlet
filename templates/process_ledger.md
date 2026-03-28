# Process Ledger — [Product Name] — [Surface/Feature]

**PRD:** [filename of the associated PRD]
**Created:** [YYYY-MM-DD]
**Last Updated:** [YYYY-MM-DD]
**Author:** [who ran the gauntlet]
**Phases completed:** [list which phases were run, e.g., "1-10 (full gauntlet)" or "8-10 (adversarial review entry)"]

---

This document is the reasoning trail for the associated PRD. The PRD is the build spec — what to build. This ledger is the receipts — why it was built this way, what else was considered, what was challenged, and what was verified.

Append each section as its phase completes. Do not backfill or rewrite earlier sections based on later decisions — the ledger is a chronological record of how the spec evolved.

---

## Phase 1: Ecosystem Snapshot

**Completed:** [YYYY-MM-DD]

### Artifact Catalog

<!-- Every document, code file, service, config, API, and external integration identified during intake. This is the universe of things this PRD could touch. -->

| Artifact | Type | Location | Relevance |
|----------|------|----------|-----------|
| | | | |

### Ecosystem Summary

<!-- Where the new idea lives in the existing landscape. What it connects to, what it depends on, what it could affect. -->

### Research Findings

<!-- Only if research was run. Delete this section if no research was conducted. -->

**Research type:** [None / External only / Internal only / Both]

#### External Landscape

<!-- Competitive map, customer signal synthesis, market positioning, sources cited. -->

#### Internal Signals

<!-- Theme clusters, frequency analysis, pain point patterns, ticket/issue references. -->

---

## Phase 2: Product Definition

**Completed:** [YYYY-MM-DD]

### Locked Definition

<!-- The problem statement, audience, positioning, and scope boundary as locked by the owner. This is the version that entered Phase 3. -->

---

## Phase 3: Decision Log

**Completed:** [YYYY-MM-DD]
**Decisions locked:** [count]
**External obligations tagged:** [count]

<!-- Full decision log with reasoning. For each decision: the question, alternatives considered, recommendation, rationale, and locked answer. Decisions with external obligations include the obligation tag. -->

### Decisions

**Decision [N]: [Question]**
Alternatives considered: [list]
Recommendation: [what the agent recommended and why]
Locked answer: [what the owner decided]
Obligation tag: [if applicable — artifact touched, location, current state]

<!-- Repeat for each decision. -->

---

## Phase 4: Stress Test Record

**Completed:** [YYYY-MM-DD]
**Scope mode:** [Expansion / Selective Expansion / Hold Scope / Reduction]
**Outcome:** [Confirmed / Reshaped / Killed]

### Premise Validation

<!-- What happens if we build nothing? Is this the right problem? -->

### Scope Calibration

<!-- Why this mode was chosen. What was expanded, held, or cut. -->

### Alternatives Considered

<!-- 2-3 product approaches that were evaluated. For each: what it prioritizes, what it sacrifices, who it serves best. -->

| Approach | Prioritizes | Sacrifices | Best For |
|----------|------------|------------|----------|
| | | | |

**Selected approach:** [which one and why]
**Rejected approaches:** [why each was rejected]

### Reshape Notes

<!-- Only if outcome was Reshaped. What changed and which Phase 3 decisions were re-grilled. Delete if Confirmed. -->

---

## Phase 5: Component Map

**Completed:** [YYYY-MM-DD]
**Components:** [count total] ([count] NEW, [count] MODIFY)

<!-- The structural decomposition. Components, connections, and classifications. -->

| Component | Type | Classification | Existing Artifact (if MODIFY) |
|-----------|------|---------------|-------------------------------|
| | | | |

### Connection Map

<!-- How components feed each other. Data flows, dependencies, integration points. -->

---

## Phase 6: Coverage Decisions

**Completed:** [YYYY-MM-DD]
**Stories written:** [count]
**Stories added during review:** [count]
**Stories removed during review:** [count]

<!-- Decisions made during story writing and owner review that altered coverage. If no stories were added or removed, note "Coverage matched component map — no changes." -->

### Changes During Review

<!-- For each story added, removed, or significantly revised during owner review: what changed and why. This captures the judgment calls that happen when the owner reacts to seeing the full story list. -->

---

## Phase 7: Assembly Decisions

**Completed:** [YYYY-MM-DD]
**PRD version:** [v1]
**Status at draft:** [e.g., "v1 — pending adversarial review"]

<!-- Judgment calls made while synthesizing the PRD from Phases 1-6. These are the decisions that don't belong to any single earlier phase but emerge during assembly. -->

### Scope Boundary Calls

<!-- Items that were close calls for In Scope vs. Out of Scope. What went where and why. -->

### Out of Scope Rationale

<!-- For each Out of Scope item: why it was excluded and whether it's a V2 candidate. -->

### Build Sequence Rationale

<!-- Why the slices were ordered this way. Which sequencing strategy was used (risk-first, value-first, dependency-first, hybrid) and why. What's in Slice 1 (walking skeleton) and why that path was chosen. -->

---

## Phase 8: Adversarial Findings

**Completed:** [YYYY-MM-DD]
**Findings:** [count total] ([count] Blocker, [count] Warning, [count] Editorial)
**All resolved:** YES / NO

<!-- Every finding from the adversarial review with its resolution. -->

### Findings

**Finding [N] — [Category]**
Severity: [Blocker / Warning / Editorial]
Location: [where in the PRD or connected doc]
Issue: [what was wrong]
Resolution: [what was decided and changed]

<!-- Repeat for each finding. -->

---

## Phase 9: Reconciliation Results

**Completed:** [YYYY-MM-DD]
**Touchpoints checked:** [count]
**Integrity checks run:** [count]
**Result:** [all PASS / FAILs found and resolved]

<!-- Summary of the reconciliation engine run. The full reconciliation pass (templates/reconciliation_pass.md) is the detailed record — this section captures the high-level outcome and any notable resolutions. -->

### Notable Resolutions

<!-- Any touchpoint or integrity check that FAILed and required changes. What was found, what was changed, in which artifact. -->

---

## Provenance

| Event | Date | Actor |
|-------|------|-------|
| Ledger created | [YYYY-MM-DD] | [who] |
| Phase 1 completed | [YYYY-MM-DD] | [who] |
| Phase 2 completed | [YYYY-MM-DD] | [who] |
| Phase 3 completed | [YYYY-MM-DD] | [who] |
| Phase 4 completed | [YYYY-MM-DD] | [who] |
| Phase 5 completed | [YYYY-MM-DD] | [who] |
| Phase 6 completed | [YYYY-MM-DD] | [who] |
| Phase 7 completed | [YYYY-MM-DD] | [who] |
| Phase 8 completed | [YYYY-MM-DD] | [who] |
| Phase 9 completed | [YYYY-MM-DD] | [who] |
| Phase 10 completed | [YYYY-MM-DD] | [who] |
| PRD finalized | [YYYY-MM-DD] | [who] |
