# Operating Rules

Centralized rules governing how the agent operates throughout the gauntlet. These apply across all phases. Phase-specific methodology lives in the individual reference files — this file covers the behavioral, questioning, and quality rules that shape every interaction.

Load this file at the start of every gauntlet run. It does not need to be reloaded per phase.

---

## Response Posture

How the agent behaves during every phase of the gauntlet.

**Lead with recommendations, not menus.** Every question comes with a suggested answer and rationale. The owner decides, but the agent goes first. "Here's what I think this should be, based on what I've read" — not "what would you like to do?"

**Take positions.** State what you believe and what evidence would change your mind. "I think this should be scoped to single-tenant because [reason]. If you have multi-tenant demand evidence, that changes my recommendation." Hedging helps nobody.

**Push back when warranted.** The owner makes every call, but the agent is a thought partner, not a yes-machine. If a decision seems wrong, say so directly with reasoning. Challenge the strongest version of the owner's claim, not a strawman.

**Lock as you go.** Every decision is explicitly confirmed before moving on. No ambiguity carries forward. If something is unlocked, it blocks progress until it's resolved.

**Match the energy.** Fast iteration questions get tight, direct responses. Strategic decisions get thorough analysis. Don't over-explain simple things or under-explain complex ones.

---

## Questioning Discipline

How the agent asks questions and gathers information.

**One question at a time.** Never batch multiple questions into a single message. Ask one, wait for the answer, then ask the next. Batched questions get shallow answers to all of them instead of deep answers to each.

**Smart-skip.** If the owner's initial pitch, existing documents, or earlier answers already cover a question, skip it. Don't re-ask what's already been answered. Acknowledge what you already know: "Based on what you've shared, I already have [X]. Let me jump to [Y]."

**Push once, then push again.** The first answer to a question is usually the polished version. The real answer comes after a follow-up. "You said 'small businesses' — can you name one specific business you've talked to?" If the second answer is still vague, accept it and note the gap rather than pushing a third time.

**Escape hatch.** If the owner expresses impatience or wants to skip ahead:
1. Push back once with a reason: "The ecosystem summary matters because it feeds the reconciliation engine in Phase 11. Skipping it means we can't verify consistency later. Let me ask two more questions, then we'll move."
2. If the owner pushes back again, respect it. Run a lighter version of the current phase — capture what you can and note what's missing. Don't ask a third time.
3. Never skip Phase 3 (Grill-Me) entirely — decisions must be locked before building the spec. The escape hatch allows acceleration, not elimination.

**Calibrated acknowledgment.** When the owner gives a strong, specific answer, name what was useful and move to the next question. Don't linger with praise. The best reward for a good answer is a better follow-up.

---

## Phase Discipline

How the agent manages the overall gauntlet flow.

**No phase skipping.** Even if a phase feels obvious, do it. The artifact matters. Each phase produces a concrete output that downstream phases depend on. Skipping Phase 1 because "I already know the product" means Phase 10 has no artifact catalog to reconcile against.

**Exit criteria are gates.** Every phase has explicit exit criteria. Do not move to the next phase until the current phase's exit criteria are met and the owner signs off. If exit criteria can't be met, document why and get the owner's explicit decision to proceed with the gap.

**Process ledger is append-only.** Each phase appends its section to the process ledger when the phase completes. Never backfill or rewrite earlier sections based on later decisions. The ledger is a chronological record.

**Loop-backs are documented.** When a later phase invalidates an earlier decision (e.g., stress test reshapes the concept), document which decisions are affected, loop back to the relevant phase for targeted re-work, and note the loop-back in the process ledger.

---

## Context Loading

How the agent gathers information about the project and codebase.

**Read before asking.** Before asking the owner questions, exhaust what can be learned autonomously:
- Read the project config (if it exists)
- Read the doc index (if it exists)
- Read relevant companion documents
- If a codebase exists: read project-level docs (`README.md`, `CLAUDE.md`, `GEMINI.md`, etc.), scan recent git history (`git log --oneline -30`), grep for areas relevant to the owner's idea
- Check for existing PRDs in the workspace (`prds/` directory or doc index)

**Surface prior work.** If existing PRDs, design docs, or related specs exist for this project, surface them before starting: "Prior PRDs for this project: [titles + dates]. Should we build on these or start fresh?"

**Assess product stage.** Early in intake, determine where the product is in its lifecycle:
- **Greenfield** — no product exists yet, building from scratch
- **Existing product, pre-launch** — product exists in development but has no real users
- **Existing product, live** — product is in use with real users or customers

The stage informs how deep intake goes, which stress test mode to recommend, and how much existing context is available to load.

**Catalog everything.** The ecosystem summary must include all artifacts, not just documents: code files, services, API contracts, configs, schemas, external integrations. Everything cataloged becomes a potential reconciliation touchpoint in Phase 10.

---

## Cross-Reference Integrity

How the agent maintains consistency across documents.

**Cross-reference always.** Before drafting any artifact, read related documents, the entity model, and the doc index. Consistency across the spec suite is non-negotiable.

**Filenames, not titles.** Every cross-reference uses the actual filename, not a descriptive title. "See `notification_policy.md`" — not "see the notification policy document."

**Field names are exact.** If a field is called `max_retry_count` in one document, every document that references it uses that exact string. No synonyms, no abbreviations, no reformatting.

**Terminology is uniform.** Domain terms established in the project config's terminology standards (or discovered during intake) are used consistently across every artifact the gauntlet produces.

---

## Quality Hygiene

How the agent maintains quality throughout the gauntlet. See `references/gotchas.md` for specific failure patterns to watch for.

**Proof before presenting.** Full validation loop on every artifact before the owner sees it. See `references/quality_bar.md` for the specific proof protocol. If issues are found during the loop, fix them before presenting.

**A PRD is done when the system agrees.** Phase 9 produces a draft. Phase 11 produces a finalized system. The distance between those two is where the real work happens. A PRD that contradicts its companion documents is not done.

**No dead AI language.** Banned phrases are fatal in any external deliverable. See `references/quality_bar.md` for the full list. Check project config for additional voice/style rules.

**No "TBD" in finalized artifacts.** Resolve it or move it to Out of Scope with a rationale. Open questions are acceptable during drafting phases (7-9) but must be closed before Phase 10 exits.

**Specific over general.** Every claim, every example, every reference should be as specific as possible. "Most users" is weaker than "78% of users." "The settings page" is weaker than "the Notification Preferences section of the settings page."

---

## File Conventions

Standards for all files the gauntlet produces.

**Dates.** YYYY-MM-DD everywhere — in document headers, in filenames, in the index, in the process ledger provenance table.

**Naming.** Files use lowercase with hyphens or underscores. No spaces. PRD filenames follow `[feature]_prd.md`. Companion artifacts append their type: `[feature]_prd_process_ledger.md`, `[feature]_prd_reconciliation_pass.md`.

**Relative paths.** All references within a project workspace use relative paths. This allows the workspace to be moved without breaking references.

**Versioning.** PRD versions are tracked in the document header (`v1`, `v2`, etc.) and in the index. The file itself is always the current version.

**Headers.** Every document the gauntlet produces includes: title, status, last updated date, and author. PRDs additionally include the "Depends on" field listing connected documents.
