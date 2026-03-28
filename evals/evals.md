# PRD Gauntlet — Eval Scenarios

Test scenarios for each entry point. Use these to verify the skill loads the right references, follows the right process, and produces the right artifacts. Scenarios use generic product concepts to validate the methodology independent of any specific project.

## Scenario 1: Full Gauntlet (with project config)

**Trigger:** "Run the full PRD gauntlet for a new notification preferences feature"
**Project:** Has a project config file in `projects/`
**Expected behavior:**
- Phase 1: Loads the project config, reads doc index and relevant companion docs. Assesses research need based on ecosystem maturity. Creates process ledger. Presents ecosystem summary.
- Phase 2: Drafts product definition positioned against existing surfaces and companion docs.
- Phase 3: Grill-me produces 15-30 locked decisions. External obligations tagged with artifact references.
- Phase 4: Recommends scope mode based on concept size. Runs three questions.
- Phases 5-7: Component map (with NEW/MODIFY classifications), stories, draft PRD using skeleton and format references.
- Phase 8: Adversarial review loads all companion docs, finds 10-40 items, walks each. Findings appended to process ledger.
- Phase 9: Reconciliation engine collects touchpoints from Phases 3/5/7, generates checks, runs them. Zero FAILs.
- Phase 10: Stores PRD, process ledger, and reconciliation pass. Distributes per project config targets.

## Scenario 2: Full Gauntlet (cold start, no config)

**Trigger:** "Start a new PRD for a project management tool for freelancers"
**Project:** None (no config file)
**Expected behavior:**
- Phase 0: No project config found. Briefs the owner on the gauntlet process. Asks for project name and workspace location. Scaffolds folder structure (`prds/`, `research/`, `deliverables/`, `source_docs/`, `index.md`, `project_config.md`). Confirms with owner.
- Phase 1: Asks structured intake questions. Populates the project config as answers come in. Assesses research need (likely recommends external research for new market). Creates process ledger.
- Phase 2: Drafts product definition using research findings for positioning.
- Proceeds through all 10 phases. Distribution targets default to the workspace structure created in Phase 0.
- Phase 10: PRD, process ledger, and reconciliation pass stored in `prds/`. Index updated. Config now reflects everything learned — ready for future gauntlet runs without Phase 0.

## Scenario 3: Adversarial Review (Phase 8 entry)

**Trigger:** "Adversarial review on [existing PRD filename]"
**Project:** Any (with or without config)
**Expected behavior:**
- Loads project config if available, reads the PRD, reads all companion docs
- Loads `references/adversarial_review.md` for methodology
- Runs three audits: internal consistency, cross-doc validation, gap detection
- Formats findings per `templates/adversarial_finding.md`
- Presents blockers first, then warnings, then editorial
- Each finding has recommendation. Walks one by one.
- Creates process ledger with Phase 8 section (or appends if ledger exists)

## Scenario 4: Research Only (Phase 1, Step 2 entry)

**Trigger:** "Research the competitive landscape for [product category]"
**Project:** Any (uses project config's Research Sources if available)
**Expected behavior:**
- Loads project config's Research Sources for starting points (if config exists)
- Launches external research agent per `references/research_protocol.md`
- Produces structured landscape summary: competitive map, customer signals, market trajectory, positioning opportunities
- Does NOT proceed to Phase 2 unless owner requests it

## Scenario 5: Stress Test (Phase 4 entry)

**Trigger:** "Stress test the [concept name] concept"
**Project:** Any
**Assumes:** Concept has been defined and grilled (decision log exists)
**Expected behavior:**
- Loads `references/stress_test.md`
- Recommends a mode based on concept size
- Runs three questions: premise challenge, scope calibration, forced alternatives
- Produces stress test summary with direction (confirmed/reshaped/killed)
- Appends Phase 4 section to process ledger

## Scenario 6: Cross-PRD Validation (Phase 9 entry)

**Trigger:** "Cross-PRD validation after updating [document name]"
**Project:** Any (with config preferred — needs doc index for dependency mapping)
**Expected behavior:**
- Reads doc index dependency map
- Identifies all docs connected to the updated document
- Collects touchpoints from dependency tables and MODIFY components
- Runs reconciliation engine from `references/reconciliation_checklist.md`
- Records in `templates/reconciliation_pass.md`
- Zero FAILs before declaring complete

## Scenario 7: Finalize (Phase 10 entry)

**Trigger:** "Finalize and ship the [PRD name]"
**Project:** Any
**Expected behavior:**
- Follows `references/distribution_map.md`
- Uses project config distribution targets if available, generic defaults if not
- Stores PRD, process ledger, and reconciliation pass in final location
- Updates doc index, open items tracker, decision log
- Verifies PRD's Companion Documents table references both companion artifacts

## Scenario 8: Stress Test Reshape → Phase 3 Loop-Back

**Trigger:** Full gauntlet run where Phase 4 reshapes the concept significantly
**Project:** Any
**Expected behavior:**
- Phases 1-3 complete normally. Decision log has 20+ locked decisions.
- Phase 4: Stress test identifies a better product approach (Question 3) that changes the scope significantly. Outcome: Reshaped.
- The agent identifies which Phase 3 decisions are invalidated by the reshape. Documents the specific decisions affected.
- Loops back to Phase 3 for a targeted re-grill — only the invalidated decisions, not the full decision tree.
- New/changed decisions get new obligation tags where applicable.
- Process ledger captures: Phase 4 reshape notes, then Phase 3 re-grill as a clearly labeled loop-back (not overwriting the original Phase 3 section).
- Proceeds to Phase 5 with the updated concept and decision log.

## Scenario 9: Adversarial Finding Invalidates a Phase 3 Decision

**Trigger:** Full gauntlet run where Phase 8 reveals a contradiction with a locked decision
**Project:** Any (with companion docs)
**Expected behavior:**
- Phases 1-7 complete normally.
- Phase 8: Cross-document validation finds that a Phase 3 decision contradicts a companion doc. The finding is a Blocker (Category 1: Direct Contradiction).
- Resolution options presented to owner: change the PRD, change the companion doc, or revisit the original decision.
- If the owner chooses to revisit: The agent documents the loop-back in the process ledger, re-grills the specific decision with the new evidence, locks a revised answer.
- The revised decision may create new obligation tags requiring Phase 9 to check additional touchpoints.
- Phase 8 continues with remaining findings after the loop-back is resolved.

## Scenario 10: Late Entry with No Workspace (Lightweight Phase 0)

**Trigger:** "Adversarial review on this doc" — owner provides a PRD file but no project config or workspace exists
**Project:** None
**Expected behavior:**
- No project config found. The agent needs to run Phase 8 but has no workspace context.
- Runs a lightweight Phase 0: creates a minimal workspace alongside the existing PRD file (or in cwd). Scaffolds the folder structure. Creates a starter config populated with whatever can be inferred from the PRD itself (product name, audience from the header block, companion docs from Section 7).
- Does NOT run the full Phase 0 briefing — the owner asked for adversarial review, not the gauntlet. Keep it fast.
- Proceeds to Phase 8. Attempts to load companion docs referenced in the PRD's dependency tables. Flags any that can't be found as UNRESOLVED.
- Creates process ledger with Phase 8 section only.
