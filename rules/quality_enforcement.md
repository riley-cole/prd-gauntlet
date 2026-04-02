# Quality Enforcement Rules

These rules replace the automated hooks available in Claude Code. Since AntiGravity and Gemini CLI do not have a hooks system, this file encodes the same enforcement as explicit behavioral rules that must be followed at all times during the gauntlet.

Load this file at the start of every gauntlet run alongside `references/operating_rules.md`.

---

## Rule 1: Proof Protocol Gate

**When:** Before writing any file to a `prds/` directory.

**Action:** Stop and run the full proof protocol before proceeding. Do not write until every item passes.

1. Re-read the entire artifact end-to-end.
2. Verify all cross-references resolve (filenames exist, field names match).
3. Check story numbers are continuous and none are missing.
4. Confirm implementation decisions don't contradict user stories.
5. Verify Out of Scope items aren't accidentally covered by stories.
6. Check dependency tables match what the PRD actually consumes/provides.

If any item fails, fix it before writing. This gate is non-negotiable — it is the last check before an artifact becomes official.

See `references/quality_bar.md` for the full proof protocol context.

---

## Rule 2: Process Ledger Discipline

**When:** After writing any PRD artifact (any file matching patterns like `*_prd*`, `*stories*`, `*component_map*`, `*ecosystem_summary*`, `*stress_test*`, `*decision_log*`, `*product_def*`).

**Action:** Immediately check — has the process ledger been updated for the current phase? Each phase appends its section to the process ledger before the phase is declared complete.

The process ledger is append-only. Never backfill or rewrite earlier sections based on later decisions. If the ledger hasn't been updated for the current phase, update it before moving on.

Phases that require ledger updates: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11. Phase 12 finalizes the ledger's Provenance table.

---

## Rule 3: Phase Boundary Validation

**When:** Before declaring any phase complete and moving to the next.

**Action:** Run through this checklist:

1. Has the phase's artifact been produced?
2. Has the owner signed off (exit criteria met)?
3. Has the process ledger been updated with this phase's section?
4. Has the Provenance table been updated with the completion date?
5. Are there any open questions or unresolved items carrying forward? If yes, document them explicitly.

Do not proceed to the next phase until all five items are confirmed.

---

## Rule 4: Cross-Reference Verification

**When:** Before presenting any artifact to the owner.

**Action:** Verify that every cross-reference in the artifact resolves:
- Every filename referenced exists
- Every field name matches its definition in the source document
- Every story number referenced exists in the story list
- Every companion document referenced exists and is current

This is a subset of the proof protocol but applies to all artifacts, not just final PRD writes.

---

## Rule 5: Terminology Consistency Check

**When:** After completing Phase 1 (once terminology standards are established) and before presenting any artifact from Phase 2 onward.

**Action:** Verify that domain terms match the project config's Terminology Standards section (or the terms established during intake if no formal config exists). Common drift patterns:

- Same role called different names across documents
- Same field called different names across documents
- Inconsistent formatting of identifiers (snake_case vs camelCase vs kebab-case)

See `references/gotchas.md` "Letting Terminology Drift" for the full pattern.
