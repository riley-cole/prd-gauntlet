---
name: riley-prd-gauntlet
description: |
  End-to-end PRD workflow from product concept through finalized, cross-validated build spec. Ten phases — intake, define, grill-me interview, stress test, component map, user stories, PRD draft, adversarial review, system validation, finalize and distribute. Supports optional deep research (competitive landscape, internal ticket mining) during intake. Project-agnostic methodology with project-specific config files for precision execution. Use when starting a new PRD, running an adversarial review, validating cross-PRD consistency, researching a product landscape, or stress-testing a concept. Trigger on: "PRD gauntlet", "riley-prd-gauntlet", "new PRD", "adversarial review", "cross-PRD validation", "stress test", "research", or "finalize the PRD."
hooks:
  PreToolUse:
    - matcher: "Write"
      hooks:
        - type: command
          if: "Write(*/prds/*)"
          command: "${CLAUDE_SKILL_DIR}/scripts/proof-gate.sh"
          timeout: 10
          statusMessage: "Checking proof protocol..."
  PostToolUse:
    - matcher: "Write"
      hooks:
        - type: command
          if: "Write(*.md)"
          command: "${CLAUDE_SKILL_DIR}/scripts/check-ledger-updated.sh"
          timeout: 10
          statusMessage: "Checking process ledger..."
        - type: command
          if: "Write(*.md)"
          command: "${CLAUDE_SKILL_DIR}/scripts/log-phase-activity.sh"
          async: true
---

# Riley's PRD Gauntlet

End-to-end process for taking a product concept from zero to a finalized, cross-validated build spec. A PRD is not done when you finish writing it. It is done when the entire system of documents agrees with it.

## Before Starting

1. **Load `references/operating_rules.md`** — behavioral rules for the entire gauntlet. Load once.
2. **Load `references/gotchas.md`** — known failure patterns. Skim at start, reference when something feels off.
3. **Identify the active project.** Check `projects/` for a matching config. Also check for `project_config.md` in an existing workspace.
4. **If config exists:** read it, skip Phase 0, start at Phase 1.
5. **If no config:** start with Phase 0.
6. **Read the doc index** if one exists.

## The Phases

Phase 0 runs once per project (first gauntlet run only). Phases 1-10 run every time. Each phase produces a concrete artifact and ends with owner sign-off.

**Phase 0:** Set up the workspace.
**Phases 1-4:** Get the concept right.
**Phases 5-7:** Build the spec.
**Phases 8-10:** Harden it against reality.

---

### Phase 0: Workspace Setup

**Goal:** Give the project a home before producing anything. Only runs when no project config exists.

Read `references/workspace_setup.md` for full methodology.

1. **Brief the owner** on what the gauntlet is, what it produces, and why we're scaffolding first. Adapt depth to the owner's familiarity — a sentence for veterans, a paragraph for newcomers.
2. **Collect:** project name (short, lowercase, hyphens) and workspace location (default: cwd).
3. **Scaffold** the folder structure from `references/workspace_setup.md`. Create starter `index.md` and `project_config.md` from `templates/project_config.md`.
4. **Confirm** what was created, then hand off to Phase 1.

**Artifact:** Project workspace with folder structure, starter index, starter config.
**Exit:** Owner confirms workspace is correct.

---

### Phase 1: Intake

**Goal:** Get smart about the ecosystem before having any opinions.

**Step 1 — Autonomous Context Loading:**

Read everything available before asking a single question.

*With project config:* config → doc index → entity model → relevant companion docs → prior PRDs.

*If a codebase exists:* README/CLAUDE.md → `git log --oneline -30` → `git diff` → grep/glob for areas relevant to the idea → map services, models, routes, configs, schemas.

*Cold start (after Phase 0):* read whatever the owner pointed to — existing folder, repo, source docs.

**Step 2 — Directed Questioning:**

Fill gaps through one-at-a-time questions. Smart-skip anything already answered by context loading.

Assess product stage first: **Greenfield** (no product) / **Pre-launch** (product exists, no users) / **Live** (real users). Stage determines questioning depth.

Core questions (skip what's already known):
1. What's the product? What does it do today?
2. Who uses it? Key actors and roles?
3. What existing documentation or specs exist?
4. What's the rough idea? *(owner always answers this one)*
5. What does this idea touch?
6. Constraints — technical, timeline, regulatory, organizational?

Populate the project config as answers come in.

**Step 3 — Research Fork (opt-in):**

Assess landscape gaps. Recommend one of: no research / internal only / external only / both parallel. See `references/research_protocol.md`.

**Step 4 — Ecosystem Summary:**

Synthesize into: what exists, where the idea lives, what it touches, constraints, risks. Name every artifact — this catalog feeds Phase 9's reconciliation engine.

**Process Ledger:** Create from `templates/process_ledger.md`. Fill header and Phase 1 section. Update Provenance.

**Artifact:** Ecosystem summary with artifact catalog. Process ledger created. Config populated.
**Exit:** Owner confirms Claude understands the landscape.

---

### Phase 2: Define

**Goal:** Draft a product definition positioned against the ecosystem.

- Problem statement, audience, positioning, scope boundary
- Position against what exists — where it lives, who it serves, what it connects to, where it stops
- Lead with a recommendation

**Process Ledger:** Append Phase 2 — the locked definition. Update Provenance.

**Artifact:** Product definition (Problem + Solution + Scope).
**Exit:** Owner says "locked."

---

### Phase 3: Grill-Me

**Goal:** Walk every branch of the decision tree. Zero open questions when done.

- One question at a time. Recommendation + rationale for each. Lock before moving on.
- **Tag external obligations:** When a decision affects something outside this PRD, tag it: what artifact, where it lives, current state. These tags feed Phase 9.

**Process Ledger:** Append Phase 3 — full decision log with reasoning, alternatives, obligation tags. Update Provenance.

**Artifact:** Numbered decision log. Decisions with external obligations tagged.
**Exit:** No open questions remain.

---

### Phase 4: Stress Test

**Goal:** Strategic checkpoint. Is this the right thing at the right size?

Read `references/stress_test.md` for full methodology.

**Three questions:**
1. **Right problem?** — What if we build nothing? More direct path? Symptom or root cause?
2. **Right size?** — Expansion / Selective Expansion / Hold Scope / Reduction. Recommend a mode.
3. **Better version?** — 2-3 distinct product approaches. Explicit recommendation.

**Outcomes:** Confirmed / Reshaped (with loop-back to Phase 3 if needed) / Killed.

**Process Ledger:** Append Phase 4 — mode, premise validation, alternatives, reshape notes. Update Provenance.

**Artifact:** Stress test summary.
**Exit:** Owner confirms direction.

---

### Phase 5: Component Map

**Goal:** Map every buildable surface, data flow, and integration point. Start from the confirmed concept (Phase 4 output).

- Discrete components: surfaces, data models, APIs, integrations
- Show connections — what feeds what
- **Classify each component:** NEW (no reconciliation needed) or MODIFY (reconciliation required — reference the existing artifact from Phase 1 catalog)

**Process Ledger:** Append Phase 5 — component table with classifications, connection map. Update Provenance.

**Artifact:** Component map with connections and NEW/MODIFY classifications.
**Exit:** Owner confirms breakdown.

---

### Phase 6: User Stories

**Goal:** Exhaustive coverage of every actor, interaction, and edge case.

- Stories for every component from Phase 5. Include system stories.
- Group by domain.
- Pressure-test: first use, error states, empty states, permissions, multi-entity, offline, cross-surface
- Count by section. Every component must have stories.

**Process Ledger:** Append Phase 6 — coverage decisions, any stories added/removed during review and why. Update Provenance.

**Artifact:** Numbered story list by domain.
**Exit:** Owner confirms coverage.

---

### Phase 7: Draft PRD

**Goal:** Synthesize everything into a single build spec.

- Scaffold from `templates/prd_skeleton.md`. Follow `references/prd_format.md`.
- Section 8 (Build Sequence): follow `references/build_sequence.md`. Integration boundaries first, then vertical slices. Slice 1 = walking skeleton.
- Run proof protocol from `references/quality_bar.md` before presenting.

**Process Ledger:** Append Phase 7 — scope boundary calls, Out of Scope rationale, build sequence ordering rationale. Update Provenance.

**Artifact:** Complete PRD. Status: "v1 — pending adversarial review."
**Exit:** Owner marks ready for adversarial review.

---

### Phase 8: Adversarial Review

**Goal:** Stress-test the PRD for gaps, contradictions, and cross-document conflicts.

Read `references/adversarial_review.md`. Format findings per `templates/adversarial_finding.md`.

1. Load full PRD + every document in the dependency table
2. Internal consistency audit → Cross-document validation → Gap detection
3. Compile findings by severity. Walk one by one with owner. Lock resolutions. Apply immediately.

**Process Ledger:** Append Phase 8 — every finding with resolution. Update Provenance.

**Artifact:** Updated PRD, version bumped, zero open findings.
**Exit:** All findings resolved.

---

### Phase 9: System Validation

**Goal:** Verify the full system is consistent. Propagate changes to every connected artifact.

See `references/reconciliation_checklist.md` for engine methodology.

1. **Collect touchpoints** from: obligation tags (Phase 3), dependency tables (Phase 7), MODIFY components (Phase 5).
2. **Resolve** each by reading the actual artifact.
3. **Generate checks** — touchpoint checks + scoped integrity checks. See `references/reconciliation_checklist.md`.
4. **Propagate changes** to connected artifacts.
5. **Run the checklist.** Record in `templates/reconciliation_pass.md`. Zero FAILs required.
6. **Update doc index.**

**Process Ledger:** Append Phase 9 — touchpoint count, integrity check count, notable resolutions. Update Provenance.

**Artifact:** All artifacts updated. Reconciliation pass with zero FAILs.
**Exit:** Zero FAILs confirmed. Owner signs off.

---

### Phase 10: Finalize & Distribute

**Goal:** Package everything for stakeholders.

Follow `references/distribution_map.md`. Use project config's Distribution Targets.

1. Move PRD to final location.
2. **Store process ledger** alongside PRD: `[prd_filename]_process_ledger.md`. Finalize Provenance.
3. **Store reconciliation pass** alongside PRD: `[prd_filename]_reconciliation_pass.md`.
4. **Verify** PRD's Companion Documents table includes both artifacts.
5. Rebuild affected deliverables.
6. Update doc index, open items tracker, decision log.

**Artifact:** Finalized PRD in place, companions stored, deliverables rebuilt, index current.
**Exit:** Owner confirms distribution complete.

---

## Rules

Load `references/operating_rules.md` at the start of every gauntlet run. It governs response posture, questioning discipline, phase management, context loading, cross-reference integrity, quality hygiene, and file conventions.

Load `references/gotchas.md` alongside it. Known failure patterns — check when something feels off.

The short version:
- Lead with recommendations, not menus
- One question at a time
- Read before asking
- Lock every decision before moving on
- No phase skipping
- Proof before presenting
- A PRD is done when the system agrees

## Entry Points

- **"Start a new PRD"** — Phase 0 (if no config) or Phase 1 (if config exists)
- **"Research [topic/market]"** — Phase 1, Step 3 (research fork)
- **"Stress test [concept]"** — Phase 4
- **"Adversarial review on [doc]"** — Phase 8
- **"Cross-PRD validation"** — Phase 9
- **"Finalize and ship"** — Phase 10
- **"Run the full gauntlet"** — Phase 0 (if no config) through Phase 10

## File Map

```
references/
  operating_rules.md         — Behavioral rules, questioning discipline, quality hygiene (load first)
  gotchas.md                 — Known failure patterns and what to do instead
  workspace_setup.md         — Phase 0: workspace structure, briefing, conventions
  prd_format.md              — PRD structure, header block, section order
  quality_bar.md             — Quality standards, banned phrases, proof protocol
  research_protocol.md       — Phase 1: research agent methodology
  build_sequence.md          — Section 8: vertical slices, integration boundaries
  stress_test.md             — Phase 4: three questions, four modes, alternatives
  adversarial_review.md      — Phase 8: finding categories, severity, audit process
  reconciliation_checklist.md — Phase 9: dynamic reconciliation engine methodology
  distribution_map.md        — Phase 10: output routing framework

templates/
  prd_skeleton.md            — Blank PRD scaffold
  project_config.md          — Auto-generated project config scaffold
  process_ledger.md          — Reasoning trail companion to the PRD
  adversarial_finding.md     — Finding format for Phase 8
  reconciliation_pass.md     — Fillable checklist for Phase 9
  phase_checklist.md         — Quick-ref: all phases

scripts/
  check-ledger-updated.sh   — PostToolUse hook: reminds to update process ledger after writing PRD artifacts
  proof-gate.sh             — PreToolUse hook: enforces proof protocol before writing to prds/
  log-phase-activity.sh     — PostToolUse hook (async): logs file writes for audit trail

projects/
  [project_name].md          — Project-specific config (docs, terminology, targets)

logs/                        — Auto-generated by phase activity hook (git-ignored, ephemeral)
```
