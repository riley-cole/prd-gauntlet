# Phase Checklist

<!-- Source of truth: SKILL.md. Update this file whenever SKILL.md phases, artifacts, or exit criteria change. -->

Quick reference for all phases. Use to verify "am I done with this phase?" before requesting owner sign-off.

| # | Phase | Mode | Artifact | Exit Criteria |
|---|-------|------|----------|---------------|
| 0 | **Workspace Setup** | Scaffolding | Project folder + starter config + index | Owner confirms workspace is set up (first run only) |
| 1 | **Intake** | Mechanical | Ecosystem summary + process ledger created | Owner confirms the agent understands the landscape |
| 2 | **Define** | Creative | Problem + Solution + Scope | Owner says "locked" |
| 3 | **Grill-Me** | Interactive | Numbered decision log | Zero open questions |
| 4 | **Stress Test** | Strategic | Confirmed or reshaped concept | Owner confirms direction |
| 5 | **Component Map** | Analytical | Component map with connections | Owner confirms breakdown |
| 6 | **User Stories** | Exhaustive | Numbered story list by domain | Owner confirms coverage |
| 7 | **Draft PRD** | Synthesis | Complete PRD markdown | Owner marks ready for review |
| 8 | **Adversarial Review** | Adversarial | Updated PRD, zero open findings | All findings resolved |
| 9 | **System Validation** | Systematic | All docs updated, reconciliation pass | Zero FAILs confirmed |
| 10 | **Finalize & Distribute** | Operational | PRD + process ledger + reconciliation pass in final location, deliverables rebuilt | Owner confirms distribution |

## Phase Groups

**Phase 0: Set up the workspace (first run only)**
- Creates project folder structure, starter config, document index
- Skipped entirely if a project config already exists

**Phases 1-4: Get the concept right**
- Intake → Define → Grill-Me → Stress Test
- Owner makes product decisions. The agent challenges and pressure-tests.

**Phases 5-7: Build the spec**
- Component Map → User Stories → Draft PRD
- The agent does the heavy lifting. Owner validates coverage and accuracy.

**Phases 8-10: Harden against reality**
- Adversarial Review → System Validation → Finalize & Distribute
- The agent stress-tests the PRD against the full document system. Owner resolves findings.

## Entry Points

Not every invocation starts at Phase 1. Supported entry points:

| Trigger | Starts At | Assumes |
|---------|----------|---------|
| "Start a new PRD" | Phase 0 (if no config) or Phase 1 | Nothing — cold start |
| "Research [topic]" | Phase 1, Step 2 | Idea exists, need landscape context |
| "Stress test [concept]" | Phase 4 | Concept is defined with locked decisions |
| "Adversarial review on [doc]" | Phase 8 | Complete PRD exists |
| "Cross-PRD validation" | Phase 9 | PRD has been reviewed, need system propagation |
| "Finalize and ship" | Phase 10 | PRD and connected docs are validated |
| "Run the full gauntlet" | Phase 0 (if no config) or Phase 1 | Nothing — full end-to-end |
