# Strategic Council — Phase 6 Reference

Multi-perspective strategic review of the Product Vision Brief. Six independent advisors analyze the product strategy through distinct lenses, peer-review each other's analyses blind, then a structured synthesis translates findings into actionable revisions before the Gauntlet moves to execution phases.

This is the last strategic checkpoint before execution. After this phase, the Gauntlet shifts to Component Maps, User Stories, and Build Sequences. Strategic errors caught here cost one document revision. Strategic errors caught at Phase 10 cost six phases of rework.

## Why This Phase Exists

By Phase 5, the PM and the agent have spent five phases in the same room. They share assumptions, vocabulary, references, and blind spots. The Vision Brief is the product of that collaboration — and it inherits every shared bias.

The Strategic Council breaks that bubble. Six independent perspectives — each with a different cognitive lens, each analyzing the brief without knowledge of what the others will say — produce signal that a two-person conversation cannot. The peer review layer catches blind spots that even six independent perspectives share.

The Council does not evaluate the document. Phase 10 (Adversarial Review) does that. The Council evaluates the **strategy the document captures** — the product thesis, the user model, the scope philosophy, the design intent, the monetization assumptions, the opportunity cost.

## When to Convene

The phase runs after every Vision Brief, but the Council itself has a triage gate. Not every brief warrants six advisors.

**Triage criteria.** Read the locked Vision Brief and evaluate:

1. Does the brief contain a strategic bet that could go either way?
2. Is there a scope boundary that reasonable people would disagree on?
3. Does the product thesis depend on an unvalidated assumption about user behavior?
4. Does the product have an unresolved or untested monetization model? *(standalone products only)*
5. Is the feature competing for resources against other high-priority work? *(platform features only)*

**If any criterion is yes:** Convene the Council. Run the full phase.

**If all criteria are no:** Log the skip in the process ledger with reasoning. Proceed to Phase 7 (Component Map). The skip is documented, not silent — future sessions can see why the Council was bypassed.

Present the triage assessment to the owner. They can override in either direction — convene when the agent recommends skipping, or skip when the agent recommends convening. Owner decides.

## The Six Advisors

Five fixed advisors run on every Council convening. A sixth advisor rotates based on product type.

### Fixed Advisors

**The Contrarian**

Assumes the strategy has fatal flaws. Looks for the thing that will kill this product — not hypothetical risk, but the specific weakness the PM is least likely to see because they're too close.

Reads the brief looking for: assumptions presented as facts, market positioning that ignores competitors' likely responses, user archetypes that are too optimistic about engagement, scope boundaries that exclude the thing that actually matters, design intent that serves the builder's taste rather than the user's needs.

Does not hedge. Does not say "but it could work if..." States the flaw, explains why it's fatal, and describes what would need to change.

**The First Principles Thinker**

Strips away every analogy, every reference, every "like X but for Y" framing, and asks: what problem are we actually solving at the deepest level of abstraction?

Reads the brief looking for: the real problem underneath the stated problem, whether the competitive framing is at the right altitude (competing against the wrong category), whether the product thesis is a feature masquerading as a product or a platform masquerading as a feature, whether the user model describes behavior as it actually is or as the PM wishes it were.

Often identifies that the right question isn't being asked. May reframe the entire product thesis at a different level of abstraction and test whether the brief still holds.

**The Expansionist**

Ignores all downside risk. Focuses entirely on upside — what happens if this succeeds beyond expectations? What adjacent opportunities does the brief leave on the table? What's the version of this product that's 10x more ambitious?

Reads the brief looking for: scope boundaries that artificially constrain value, user archetypes that could be expanded, key moments that hint at a bigger product, integrations or partnerships that the brief doesn't consider, network effects or compounding advantages that the current scope doesn't capture.

Does not caveat with feasibility. That's someone else's job. The Expansionist's job is to name the ceiling the brief doesn't reach for.

**The Outsider**

Has no domain knowledge. No familiarity with the industry, the references, the jargon, or the competitive landscape. Reads the brief as a smart person who found it on a table.

Reads the brief looking for: assumptions that depend on domain expertise the user might not have, emotional appeals that only resonate with insiders, references that aren't decomposed enough for a stranger to understand, product thesis statements that require context to parse, scope philosophies that make sense to the builder but not to someone encountering the product cold.

Catches the curse of knowledge — the gap between what feels obvious after five phases of collaboration and what's actually obvious to a new user, a new team member, or a potential investor.

**The User Advocate**

Inhabits the user's actual life and asks whether the product earns a place in it. Not "is the strategy compelling" but "would I actually change my behavior for this?"

Reads the brief looking for: adoption friction the brief doesn't acknowledge, habit formation requirements that are unrealistic, moments that sound magical in a brief but wouldn't survive a tired user's Wednesday afternoon, value propositions that require sustained effort before payoff, assumptions about user motivation that don't survive contact with real routines.

Different from the Outsider: the Outsider doesn't understand the domain. The User Advocate understands it deeply — they're living the life the brief describes — but they're skeptical about whether the product earns space in that life. They catch the gap between "this would be cool to have" and "I would actually use this."

### The Sixth Seat (Rotates)

The sixth advisor is determined by product type. The agent recommends; owner confirms.

**For standalone products, new ventures, or products with an open business model →**

**The Monetization Strategist**

Reads the brief and asks: what is the business model implied by this product vision, and does the vision support it?

Identifies the revenue logic embedded in product decisions — often decisions the PM made without realizing they were monetization decisions. Scope philosophy, engagement patterns, user archetypes, and design intent all constrain or enable specific monetization models.

Reads the brief looking for: engagement patterns that eliminate attention-based revenue models, user archetypes with asymmetric monetization potential (which archetype funds the business?), scope philosophy that conflicts with subscription or premium-tier value propositions, value curves that require long adoption periods before the product justifies a price, growth-vs-revenue tensions the brief doesn't acknowledge.

Does not produce pricing tables or financial projections. Identifies the monetization *constraints* the brief creates and tests whether the PM has a credible path through them.

**For internal features, platform additions, or products within an established revenue model →**

**The Resource Strategist**

Reads the brief and asks: is this the best use of what we have right now, given everything else competing for the same resources?

Evaluates opportunity cost at the portfolio level. Every other advisor evaluates the product on its own merits. The Resource Strategist evaluates it against the things it displaces.

Reads the brief looking for: opportunity cost against other queued work, complexity cost (ongoing maintenance burden vs. one-time build), sequencing risk (does this feature depend on other features that don't exist yet?), the "do nothing" baseline applied to timing rather than concept (is this the right idea at the wrong time?), prerequisites the brief assumes are in place but aren't.

Different from the Stress Test's "what if we build nothing?" question: the Stress Test asks that about the concept. The Resource Strategist asks it about the timing and the tradeoffs against specific alternatives.

---

## The Process

### Step 1: Frame the Question

Read the locked Vision Brief in full. Construct a neutral framing prompt for the advisors:

```
Given the following product strategy [Vision Brief content], analyze this from your assigned perspective. Where is the strategy strong? Where is it vulnerable? What is it not seeing?

Your constraints:
- 150-300 words
- Lean fully into your assigned lens. No hedging, no "on the other hand."
- React to the STRATEGY, not the document. The brief is a vehicle. You are evaluating the product thinking it captures.
- Be specific. Name the section, the decision, the assumption you're challenging or validating. General observations waste everyone's time.
```

Include relevant context from earlier phases if it strengthens the framing — the stress test outcome, key Phase 3 decisions, the ecosystem summary. The advisors should have enough context to produce specific analysis, not generic commentary.

### Step 2: Convene the Council

Spawn all six advisors simultaneously as independent analyses. Each advisor:

- Reads the full Vision Brief
- Reads the framing prompt
- Writes their 150-300 word analysis from their assigned perspective
- Does not see any other advisor's output

The analyses must be independent. No advisor references, responds to, or builds on another's work. The value of the Council depends on genuine independence — six perspectives that converge or diverge on their own merits.

### Step 3: Peer Review

Anonymize the six advisor responses. Shuffle the mapping — the Contrarian is not always Advisor A. Label them Advisor A through F.

Each advisor reads all six anonymized responses (including their own, which they won't recognize in anonymized form) and answers three questions:

1. **Which response is the strongest, and why?** (One sentence.)
2. **What is the biggest blind spot across all six responses?** Not a weakness of one response — a gap that all six share.
3. **What did all six miss?** The thing that none of the perspectives caught.

The anonymization prevents role deference. Advisors evaluate arguments, not labels. The First Principles Thinker might rate the User Advocate's analysis as the most important. The Outsider might identify that every advisor assumed a constraint that isn't actually fixed.

Question 3 is the highest-value question. Six independent perspectives each have their own blind spots. The peer review forces each advisor to look for the gap that all six share. That shared blind spot is often the deepest insight the Council produces.

### Step 4: Chairman Synthesis

De-anonymize all responses. Read the six original analyses plus the six peer reviews. Produce a synthesis with four sections:

**Where the Council Agrees.**
High-confidence signals. Convergence across 4+ advisors on the same strength or weakness — from different angles — is strong signal. Name what they converged on and why the convergence matters.

**Where the Council Clashes.**
Genuine disagreements where reasonable perspectives diverge. Name both sides without resolving the tension. These are decision points for the owner, not problems for the synthesis to solve. Frame each clash as a clear choice: "The Expansionist argues X. The User Advocate argues Y. The tradeoff is [specific]."

**Blind Spots Caught.**
Insights surfaced by peer review that no individual advisor initially covered. These are often the most valuable findings because they identify assumptions so embedded that six different lenses all missed them.

**Overall Assessment.**
Not a verdict. A characterization of the brief's strategic health: where it's solid, where it needs work, and the overall magnitude of revision required. Sets expectations before the finding walk.

### Step 5: Findings Extraction

Translate the synthesis into discrete, numbered findings. Each finding gets:

- **Finding:** What was identified (one sentence)
- **Source:** Which advisor(s) surfaced it, and whether peer review reinforced it
- **Affects:** Which section(s) of the Vision Brief
- **Severity:**
  - **Confirm** — The brief is right. The finding validates an existing decision.
  - **Revise** — The brief needs a specific update. The agent proposes the edit.
  - **Discuss** — Unresolved. The owner's input is needed before a revision can be proposed.

This mirrors the Adversarial Review's finding format. Same structure the owner is already familiar with from Phase 10.

### Step 6: Finding Walk

Present findings to the owner one at a time. Revise and Discuss findings first (these require decisions). Confirm findings summarized at the end (these are informational).

**For each Revise finding:**
- Present the finding and the affected Vision Brief section
- Propose a specific edit to the section
- Owner approves, modifies, or rejects
- If rejected: log rationale in process ledger ("considered and rejected — [reason]")
- Lock before moving to the next finding

**For each Discuss finding:**
- Present the tension — what the Council surfaced and why it's unresolved
- Present both sides if the Council clashed on it
- Ask the owner for their call
- Based on the decision, either propose a revision or log as resolved with rationale
- Lock before moving to the next finding

**For Confirm findings:**
- Summarize as a batch: "The Council validated [X, Y, Z]. No changes needed."
- Available in detail in the appendix if the owner wants to read the reasoning

Same lock-before-moving-on discipline as Grill-Me and Adversarial Review. No finding carries forward unresolved.

### Step 7: Brief Update and Re-lock

If any revisions were approved:

1. Apply all approved edits to the Vision Brief
2. Re-read the full brief for coherence — revising Section 6 might create a contradiction with Section 1
3. If coherence issues are found, present them as additional findings and walk them
4. Present the updated brief for final lock
5. Version bump the brief (e.g., v1 → v1.1, or v1 → v2 depending on revision magnitude)

If no revisions were needed: confirm the brief holds as-is and proceed.

### Step 8: Process Ledger

Append Phase 6 with:

- **Council convened:** Yes/No (if No, log triage reasoning and skip to Phase 7)
- **Sixth seat:** Monetization Strategist or Resource Strategist, with rationale
- **Findings count:** Total findings, broken down by Confirm / Revise / Discuss
- **Key agreements:** What the Council converged on (high-confidence signals)
- **Key clashes:** Genuine disagreements and how they were resolved
- **Blind spots caught:** Peer review insights not in any individual analysis
- **Revisions applied:** Which Vision Brief sections were updated and why
- **Findings rejected:** Which findings were considered and rejected, with owner's rationale
- **Brief version:** Updated version number

Update Provenance.

---

## Phase Outcomes

Three possible results, emerging from the finding walk:

**Confirmed.** All findings are Confirm severity, or Revise/Discuss findings were minor and resolved during the walk. The Vision Brief holds. Proceed to Phase 7 (Component Map).

**Revised.** One or more findings produced meaningful revisions to the Vision Brief. Brief updated, re-locked, version bumped. Proceed to Phase 7 with the updated brief as the foundation.

**Loop-back.** A finding is fundamental enough that it invalidates decisions from Phase 3 (Grill-Me), Phase 4 (Stress Test), or Phase 5 (Vision Brief extraction). Document which decisions are affected. Loop back to the relevant phase for targeted rework. After rework, return to Phase 6 for a focused re-evaluation of the affected sections (not a full Council re-run unless the changes are extensive).

---

## Adapting the Framework

**If the brief is very strong and the triage gate barely triggered:** The Council may produce mostly Confirm findings. That's a valid outcome — it means the strategy survived six independent stress tests. Don't manufacture Revise findings to justify the phase's existence. A clean Council pass is a high-confidence signal.

**If the Council produces conflicting Revise recommendations:** Two advisors may propose opposite changes to the same section. Present both to the owner as a Discuss finding with both proposed edits visible. The owner picks a direction or synthesizes a third option.

**If a peer review question surfaces something bigger than any individual finding:** Sometimes "what did all six miss?" produces an insight that reframes the entire brief. Treat this as a Discuss finding at the highest severity. It may trigger a loop-back.

**If the owner disagrees with the synthesis framing:** The Chairman synthesis is the agent's interpretation. The owner may read the individual advisor responses and reach a different conclusion. That's valid. The finding walk is where the owner's interpretation takes precedence.

**If the brief was produced outside the Gauntlet:** The Council can be invoked as a standalone phase on any Vision Brief or strategy document, not just Gauntlet-produced ones. Frame the question appropriately and run the full process. The triage gate still applies.

---

## Relationship to Other Phases

- **Receives from Phase 5 (Product Vision Brief):** The locked brief is the Council's input. The Council does not produce the brief — it stress-tests the strategy the brief captures.
- **Feeds Phase 7 (Component Map):** A Council-validated brief produces a higher-confidence component map. Findings that were rejected with rationale give the Component Map context about intentional tradeoffs.
- **Feeds Phase 8 (User Stories):** Council findings about user archetypes and adoption friction refine the "As a [user]" framing and acceptance criteria.
- **Feeds Phase 10 (Adversarial Review):** The Council's process ledger entry becomes a companion artifact. If the PRD contradicts a Council finding that was accepted, that's an adversarial finding. If it contradicts a finding that was rejected, the rejection rationale is available.
- **Distinct from Phase 4 (Stress Test):** The Stress Test challenges the concept's viability ("right problem, right size, better version?"). The Council challenges the strategy's articulation ("is the Vision Brief's expression of this concept complete, defensible, and buildable?"). Phase 4 asks "should we build this?" Phase 6 asks "have we described what we're building accurately and completely?"
- **Distinct from Phase 10 (Adversarial Review):** The Adversarial Review is a document-level audit — consistency, contradictions, gaps. The Council is a strategy-level audit — assumptions, blind spots, tradeoffs. Phase 10 asks "does the system of documents agree?" Phase 6 asks "is the strategy worth building a system of documents around?"

---

## Appendix: Advisor Response Template

For consistency across Council runs, each advisor structures their response as:

```
**[Advisor Role]**

**Strategic assessment:** [One sentence — the brief's biggest strength or biggest vulnerability from this lens]

**Analysis:** [150-300 words. Specific. Names sections, decisions, assumptions. No hedging.]

**If I could change one thing about this strategy:** [One concrete recommendation]
```

## Appendix: Peer Review Template

```
**Reviewing all six responses (anonymized):**

1. **Strongest response:** [Letter] — [One sentence on why]
2. **Biggest shared blind spot:** [What all six under-examined or assumed without testing]
3. **What all six missed:** [The gap none of them caught]
```
