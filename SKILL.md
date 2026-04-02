---
name: riley-prd-gauntlet
description: |
  End-to-end PRD workflow from product concept through finalized, cross-validated build spec. Twelve phases — intake, define, grill-me interview, stress test, product vision brief, strategic council, component map, user stories, PRD draft, adversarial review, system validation, finalize and distribute. Supports optional deep research (competitive landscape, internal ticket mining) during intake. Project-agnostic methodology with project-specific config files for precision execution. Use when starting a new PRD, running an adversarial review, validating cross-PRD consistency, researching a product landscape, stress-testing a concept, or running a strategic council review. Trigger on: "PRD gauntlet", "riley-prd-gauntlet", "new PRD", "adversarial review", "cross-PRD validation", "stress test", "strategic council", "research", or "finalize the PRD."
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
3. **On platforms without hooks support** (Gemini/AntiGravity, Codex, etc.), also load `rules/quality_enforcement.md` — behavioral enforcement of the same gates the hooks provide on Claude Code. On Claude Code, the hooks fire automatically; this file is not needed.
4. **Identify the active project.** Check `projects/` for a matching config. Also check for `project_config.md` in an existing workspace.
5. **If config exists:** read it, skip Phase 0, start at Phase 1.
6. **If no config:** start with Phase 0.
7. **Read the doc index** if one exists.

## The Phases

Phase 0 runs once per project (first gauntlet run only). Phases 1-12 run every time. Each phase produces a concrete artifact and ends with owner sign-off.

**Phase 0:** Set up the workspace.
**Phases 1-4:** Get the concept right.
**Phase 5:** Bridge concept to execution (Product Vision Brief).
**Phase 6:** Stress-test the strategy (Strategic Council).
**Phases 7-9:** Build the spec.
**Phases 10-12:** Harden it against reality.

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

*If a codebase exists:* README/CLAUDE.md/GEMINI.md (platform-specific project config) → `git log --oneline -30` → `git diff` → grep/glob for areas relevant to the idea → map services, models, routes, configs, schemas.

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

Synthesize into: what exists, where the idea lives, what it touches, constraints, risks. Name every artifact — this catalog feeds Phase 10's reconciliation engine.

**Process Ledger:** Create from `templates/process_ledger.md`. Fill header and Phase 1 section. Update Provenance.

**Artifact:** Ecosystem summary with artifact catalog. Process ledger created. Config populated.
**Exit:** Owner confirms the agent understands the landscape.

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
- **Tag external obligations:** When a decision affects something outside this PRD, tag it: what artifact, where it lives, current state. These tags feed Phase 10.

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

### Phase 5: Product Vision Brief

**Goal:** Produce a polished, standalone strategy document that bridges concept (Phases 1-4) to execution (Phases 6-8). This is the handoff artifact that lets designers, marketers, collaborators, and future team members move the ball forward in their own domain without needing the full PRD.

Read `references/product_vision_brief.md` for full methodology and template.

A Product Vision Brief is NOT a PRD. It describes what the product IS and what it should FEEL like, with enough specificity that someone who wasn't in the room can build toward the same target. It does not contain data models, component maps, or acceptance criteria.

**Seven sections:**

1. **The Product Thesis** — what this is, who it's for, why now. Plain language. The version you'd explain over dinner.

2. **The User and Their World** — real people, not personas. Enough depth that a designer reading this feels like they KNOW these users. What their life looks like today, what's broken, what they wish existed.

3. **The Key Moments** — the 5-8 moments that define the product experience. Not screens, moments. Each gets: what happens, what the user feels, what makes it magic vs mundane.

4. **The Reference Decomposition** — take each external reference (apps, products, brands the owner has cited as inspiration) and pull it apart into specific transferable principles. Not "like Flighty" but "Flighty's progressive disclosure card model, applied to [specific surface]." For each reference: what you're taking, what you're NOT taking, and how it translates to THIS product. This is where vague "I want something like X meets Y" becomes actionable design direction.

5. **Design Intent** — the emotional and visual direction. Not hex codes... the mood. Photos, screenshots, mood references that capture the vibe. The anti-patterns to avoid. Enough specificity that a designer can start a visual system without guessing.

6. **Scope and Anti-Scope** — what V1 does and does not do, framed as philosophy, not feature lists. "This is an app you open after the round, not during it" is a scope statement that a designer, marketer, or engineer can all use to make independent decisions that align.

7. **Open Questions and Risks** — what isn't locked. Named honestly.

**Who this unlocks:**
- A designer can start visual exploration, mood boards, screen concepts
- A marketer can start positioning and messaging
- A collaborator or co-founder can evaluate whether they want to build this
- A friend can understand the product well enough to give useful feedback
- The Gauntlet's own Phases 6-8 get sharper because design thinking has already started

**Process Ledger:** Append Phase 5 — key references decomposed, design intent decisions, scope philosophy. Update Provenance.

**Artifact:** Standalone Product Vision Brief document. Polished enough to hand to anyone outside the process.
**Exit:** Owner confirms the brief captures the product intent and is ready for external consumption.

---

### Phase 6: Strategic Council

**Goal:** Multi-perspective strategic review of the Vision Brief before execution begins. Six independent advisors analyze the product strategy through distinct lenses, peer-review each other blind, then a structured synthesis translates findings into actionable revisions.

Read `references/strategic_council.md` for full methodology, advisor definitions, peer review process, and synthesis format.

**Triage gate:** Read the locked Vision Brief against five criteria. If any criterion is yes, convene the Council. If all are no, log the skip and proceed to Phase 7. Owner can override in either direction.

**Six advisors (five fixed, one rotating):**

Fixed: Contrarian, First Principles Thinker, Expansionist, Outsider, User Advocate.

Sixth seat rotates:
- **Standalone products / open business model →** Monetization Strategist
- **Platform features / established revenue model →** Resource Strategist

**Process:**
1. Frame the question from the Vision Brief
2. Spawn all six advisors independently (150-300 words each, no hedging)
3. Anonymize responses, peer review (strongest response, shared blind spot, what all missed)
4. Chairman synthesis (agrees, clashes, blind spots, overall assessment)
5. Extract discrete numbered findings with severity (Confirm / Revise / Discuss)
6. Walk findings one at a time with owner — Revise and Discuss first, Confirm summarized
7. Apply approved revisions to Vision Brief, re-lock
8. Log everything in process ledger

**Outcomes:** Confirmed / Revised (brief updated, re-locked) / Loop-back (to Phase 3, 4, or 5 for targeted rework).

**Process Ledger:** Append Phase 6 — council convened (yes/no), sixth seat selection, findings count by severity, key agreements, key clashes, blind spots caught, revisions applied, findings rejected with rationale, brief version. Update Provenance.

**Artifact:** Council synthesis with findings log. Updated Vision Brief (if revised).
**Exit:** All findings resolved. Owner confirms brief is ready for execution phases.

---

### Phase 7: Component Map

**Goal:** Map every buildable surface, data flow, and integration point. Start from the confirmed concept (Phase 4 output) informed by the council-validated vision brief (Phases 5-6).

- Discrete components: surfaces, data models, APIs, integrations
- Show connections — what feeds what
- **Classify each component:** NEW (no reconciliation needed) or MODIFY (reconciliation required — reference the existing artifact from Phase 1 catalog)

**Process Ledger:** Append Phase 7 — component table with classifications, connection map. Update Provenance.

**Artifact:** Component map with connections and NEW/MODIFY classifications.
**Exit:** Owner confirms breakdown.

---

### Phase 8: User Stories

**Goal:** Exhaustive coverage of every actor, interaction, and edge case.

- Stories for every component from Phase 7. Include system stories.
- Group by domain.
- Pressure-test: first use, error states, empty states, permissions, multi-entity, offline, cross-surface
- Count by section. Every component must have stories.

**Process Ledger:** Append Phase 8 — coverage decisions, any stories added/removed during review and why. Update Provenance.

**Artifact:** Numbered story list by domain.
**Exit:** Owner confirms coverage.

---

### Phase 9: Draft PRD

**Goal:** Synthesize everything into a single build spec.

- Scaffold from `templates/prd_skeleton.md`. Follow `references/prd_format.md`. Includes Doc Index section between Solution and User Stories.
- Section 8 (Build Sequence): follow `references/build_sequence.md`. Integration boundaries first, then vertical slices. Slice 1 = walking skeleton.
- Run proof protocol from `references/quality_bar.md` before presenting.

**Process Ledger:** Append Phase 9 — scope boundary calls, Out of Scope rationale, build sequence ordering rationale. Update Provenance.

**Artifact:** Complete PRD. Status: "v1 — pending adversarial review."
**Exit:** Owner marks ready for adversarial review.

---

### Phase 10: Adversarial Review

**Goal:** Stress-test the PRD for gaps, contradictions, and cross-document conflicts.

Read `references/adversarial_review.md`. Format findings per `templates/adversarial_finding.md`. Note: the Vision Brief (Phase 5) and Strategic Council findings (Phase 6) are companion documents that get loaded during the adversarial review alongside the PRD.

1. Load full PRD + every document in the dependency table
2. Internal consistency audit → Cross-document validation → Gap detection
3. Compile findings by severity. Walk one by one with owner. Lock resolutions. Apply immediately.

**Process Ledger:** Append Phase 10 — every finding with resolution. Update Provenance.

**Artifact:** Updated PRD, version bumped, zero open findings.
**Exit:** All findings resolved.

---

### Phase 11: System Validation

**Goal:** Verify the full system is consistent. Propagate changes to every connected artifact.

See `references/reconciliation_checklist.md` for engine methodology.

1. **Collect touchpoints** from: obligation tags (Phase 3), dependency tables (Phase 9), MODIFY components (Phase 7).
2. **Resolve** each by reading the actual artifact.
3. **Generate checks** — touchpoint checks + scoped integrity checks. See `references/reconciliation_checklist.md`.
4. **Propagate changes** to connected artifacts.
5. **Run the checklist.** Record in `templates/reconciliation_pass.md`. Zero FAILs required.
6. **Update doc index.**

**Multi-PRD reconciliation:** When multiple PRDs share dependencies, run Phase 11 across all PRDs simultaneously — not per-PRD. Load the full system, generate cross-document checks, and walk findings one by one. Use the double-blind audit pattern from `references/build_sequence.md` for validation.

**Process Ledger:** Append Phase 11 — touchpoint count, integrity check count, notable resolutions. Update Provenance.

**Artifact:** All artifacts updated. Reconciliation pass with zero FAILs.
**Exit:** Zero FAILs confirmed. Owner signs off.

---

### Phase 12: Finalize & Distribute

**Goal:** Package everything for stakeholders.

Follow `references/distribution_map.md`. Use project config's Distribution Targets.

1. Move PRD to final location.
2. **Store process ledger** alongside PRD: `[prd_filename]_process_ledger.md`. Finalize Provenance.
3. **Store reconciliation pass** alongside PRD: `[prd_filename]_reconciliation_pass.md`.
4. **Store council synthesis** alongside PRD (if council was convened): `[prd_filename]_council_synthesis.md`.
5. **Verify** PRD's Companion Documents table includes all companion artifacts.
6. Rebuild affected deliverables (including Vision Brief if Phase 5 artifact needs updating).
7. Update doc index, open items tracker, decision log.
8. **If multi-PRD:** create or update the Build Orchestration Plan alongside the PRDs. See `references/build_sequence.md` Multi-PRD section.

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
- **"Product vision brief"** — Phase 5
- **"Strategic council on [doc]"** — Phase 6 (can run standalone on any Vision Brief or strategy document)
- **"Adversarial review on [doc]"** — Phase 10
- **"Cross-PRD validation"** — Phase 11
- **"Finalize and ship"** — Phase 12
- **"Run the full gauntlet"** — Phase 0 (if no config) through Phase 12
- **Build Sequence audit:** "audit the build plan", "validate slices". Runs double-blind validation on existing Build Sequences — story coverage, dependency chains, unlock annotations, done criteria quality, orchestration plan accuracy.

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
  product_vision_brief.md    — Phase 5: vision brief methodology and template
  strategic_council.md       — Phase 6: six advisors, peer review, synthesis, finding walk
  adversarial_review.md      — Phase 10: finding categories, severity, audit process
  reconciliation_checklist.md — Phase 11: dynamic reconciliation engine methodology
  distribution_map.md        — Phase 12: output routing framework

templates/
  prd_skeleton.md            — Blank PRD scaffold
  project_config.md          — Auto-generated project config scaffold
  process_ledger.md          — Reasoning trail companion to the PRD
  adversarial_finding.md     — Finding format for Phase 10
  reconciliation_pass.md     — Fillable checklist for Phase 11
  phase_checklist.md         — Quick-ref: all phases

scripts/
  check-ledger-updated.sh   — PostToolUse hook: reminds to update process ledger after writing PRD artifacts
  proof-gate.sh             — PreToolUse hook: enforces proof protocol before writing to prds/
  log-phase-activity.sh     — PostToolUse hook (async): logs file writes for audit trail

projects/
  [project_name].md          — Project-specific config (docs, terminology, targets)

logs/                        — Auto-generated by phase activity hook (git-ignored, ephemeral)
```
