# Gotchas

Real failure patterns from running the gauntlet. Each gotcha describes a specific way the agent tends to go wrong, why it matters, and what to do instead. Check this file when something feels off — odds are the pattern is documented here.

---

## Batching Questions During Intake

**The failure:** Asking 3-5 questions in a single message during Phase 1 or Phase 3. Feels efficient. Gets shallow answers to all of them instead of deep answers to each.

**Why it matters:** Shallow answers produce a shallow ecosystem summary. The grill-me decisions are only as good as the specificity they're grounded in. One vague answer to a batched question can cascade into an ambiguous PRD.

**What to do instead:** One question at a time. Wait for the answer. Let the answer inform the next question. If the owner gives a short answer, push once for specificity before moving on.

---

## Generic Ecosystem Summaries

**The failure:** Producing an ecosystem summary that reads like a product marketing page. "The platform serves multiple user types with configurable settings." That tells nobody anything.

**Why it matters:** The ecosystem summary feeds Phase 9's reconciliation engine. Every artifact cataloged here becomes a reconciliation touchpoint. A vague summary produces vague touchpoints produces a checklist that catches nothing.

**What to do instead:** Name every artifact. Use filenames, not descriptions. Count things — "3 existing PRDs, 1 entity model, 2 API contracts, 14 config files." Reference the specific docs, code files, services, configs, and schemas. If you can't name it, you haven't loaded it.

---

## Skipping the Reconciliation Engine

**The failure:** Treating Phase 9 as a formality. Running a quick "does this look consistent?" pass instead of actually collecting touchpoints from Phases 3/5/7, resolving each artifact, and generating specific checks.

**Why it matters:** The reconciliation engine is where the gauntlet earns its keep. A PRD that contradicts its companion documents is worse than no PRD — it creates confident wrongness. The engine is the only thing standing between "draft is done" and "system agrees."

**What to do instead:** Follow the engine methodology in `references/reconciliation_checklist.md` step by step. Collect touchpoints from all three sources. Resolve each one by reading the actual artifact. Generate checks that name specific fields, terms, and behaviors. Every check must be falsifiable.

---

## Under-Tagging External Obligations

**The failure:** During Phase 3, locking a decision that affects an external artifact without tagging what it touches. "We'll use real-time notifications" — locked, move on. But nobody tagged that this changes `notification_service.py` and `notification_policy.md`.

**Why it matters:** Phase 9's reconciliation engine collects touchpoints from obligation tags. No tag means no touchpoint means no check means the external artifact silently disagrees with the PRD.

**What to do instead:** Every decision that changes something outside this PRD gets a tag: what artifact it touches, where that artifact lives, and what the current state is. If you're not sure whether a decision has external impact, it probably does.

---

## Writing Horizontal Slices in Build Sequence

**The failure:** Structuring the Build Sequence as "Slice 1: all the database stuff. Slice 2: all the API stuff. Slice 3: all the UI stuff." Horizontal layers instead of vertical slices.

**Why it matters:** Horizontal slices aren't demoable. You can't show a stakeholder "all the database stuff." Each slice should produce something a human can see and react to. The walking skeleton principle exists because integration problems surface at seams, and horizontal slices defer all seam-crossing to the end.

**What to do instead:** Each slice fires a thin round through every layer. Slice 1 is the narrowest possible end-to-end path. Every subsequent slice adds a capability someone can demo. Story numbers trace back to each slice.

---

## Losing the Process Ledger Mid-Gauntlet

**The failure:** Creating the process ledger in Phase 1, then forgetting to append sections in Phases 2-5, then trying to reconstruct everything from memory during Phase 8.

**Why it matters:** The process ledger is the reasoning trail. It records why decisions were made, what alternatives were rejected, and what obligations were identified. Reconstructing it after the fact produces a sanitized narrative, not an honest record.

**What to do instead:** Every phase that produces a section in the process ledger appends it before declaring the phase complete. The hooks enforce this — but if something slips through, check the ledger at phase boundaries.

---

## Over-Specifying Implementation Details

**The failure:** Filling the PRD with API endpoint names, database schema DDL, class hierarchies, or specific framework choices. "Use a Redux store with these specific reducers" in a product spec.

**Why it matters:** The PRD specifies what to build and why. Implementation decisions in the PRD become constraints that may be wrong by the time engineering starts. The Build Sequence specifies integration boundaries and vertical slices — not internal architecture.

**What to do instead:** Specify behavior, not mechanism. "The dashboard refreshes every 15 minutes" not "use a cron job that runs every 15 minutes." Specify boundaries at system seams. Leave everything inside a boundary to engineering.

---

## Treating the Stress Test as a Rubber Stamp

**The failure:** Running Phase 4 as "the concept looks good, let's confirm and move on." Question 1 gets a one-sentence "premise holds." Question 3 generates alternatives that are obviously worse than the settled concept. Nobody's mind was at risk of changing.

**Why it matters:** The stress test exists because teams build the wrong thing at the wrong size more often than they build the right thing badly. If the alternatives aren't genuinely competitive with the settled concept, they're not real alternatives.

**What to do instead:** Question 1 should make the owner uncomfortable — "what if we build nothing?" needs a real answer. Question 3 alternatives must be genuinely different product approaches, not strawmen. At least one alternative should make the owner pause.

---

## Forgetting Empty States

**The failure:** Every surface looks great with data. Nobody specified what the user sees on first login, after clearing all items, when the search returns nothing, or when the filter produces zero results.

**Why it matters:** Empty states are the first thing users see. They're also the states most likely to trigger confusion or support tickets. An unspecified empty state gets whatever the engineer thinks is reasonable, which is usually a blank page.

**What to do instead:** The adversarial review in Phase 8 checks for this explicitly. But don't wait for Phase 8. During story writing in Phase 6, ask for every surface: "What does this look like with zero data?" Add a system story for each empty state.

---

## Letting Terminology Drift

**The failure:** The PRD calls it "team lead." The entity model calls it "manager." The companion doc calls it "supervisor." Same role, three names.

**Why it matters:** Engineers build what the spec says. If the spec uses three names for one thing, they may build three things — or, more likely, pick one name and leave the other two as dead references that confuse everyone later.

**What to do instead:** Establish terminology in Phase 1 (from the project config or during intake). Use those exact terms everywhere. The reconciliation engine in Phase 9 checks terminology consistency, but catching drift early is cheaper than fixing it in Phase 9.

---

## Doc Overview Language in Problem Statement

**The failure:** The Problem Statement opens with the user's pain, then drifts into "This PRD defines the complete analytics and reporting experience within HomeRoom." That's document scope, not the problem. It tells the reader what the document covers, not what gap exists.

**Why it matters:** The Problem Statement is the foundation every subsequent decision is evaluated against. If it blends pain with scope, the stress test (Phase 4) loses its anchor — you're testing whether the document is right, not whether the solution is right.

**What to do instead:** Keep the Problem Statement pure. Who feels the pain, what the pain is, why it matters. No "this document," no "this PRD," no solution hints. Document scope belongs in the Doc Index (Section 2.5), which exists specifically to tell the reader what's in the document.

---

## Missing Done Criteria on Slices

**The failure:** Build Sequence slices have acceptance criteria ("Dashboard shows KPI cards") but no done criteria ("KPI card shows correct value matching manual sum of transactions"). Engineers know what to build but not how to verify it's built correctly.

**Why it matters:** Without done criteria, "done" is a judgment call. One engineer thinks the slice is shipped, another thinks it needs more testing, the PM thinks it was done two days ago. Done criteria are the contract — every box checked means the slice is landed and downstream work can begin.

**What to do instead:** Every slice gets both acceptance criteria (product behaviors) and done criteria (pass/fail tests). Done criteria must be testable, pass/fail, edge-case-aware, and data-contract-complete. If the slice produces data consumed downstream, there's a done criterion verifying the data is available. The format is a checkbox list — no ambiguity about what's left.

---

## Orphaned Cross-PRD Dependencies

**The failure:** AdvisorLounge Slice 7 says "Unlocks: FrontOffice Slice 3" but FrontOffice Slice 3's Dependencies field doesn't mention AdvisorLounge Slice 7. The unlock chain is one-directional. An engineer reading only the downstream PRD misses the dependency.

**Why it matters:** Cross-PRD dependencies are the highest-risk joints in a multi-PRD system. If they're only annotated on one side, the other side can be built against wrong assumptions. The double-blind audit exists specifically to catch these mismatches.

**What to do instead:** Every cross-PRD dependency must be bidirectionally annotated. Upstream slice says "Unlocks: [downstream]." Downstream slice says "Dependencies: [upstream]." Both must name the specific slice and what data/config flows between them. After writing Build Sequences, run the double-blind audit pattern to verify all cross-references resolve in both directions.
