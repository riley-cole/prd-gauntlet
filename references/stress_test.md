# Stress Test

Strategic checkpoint methodology for Phase 4. After the grill-me produces a settled concept with locked decisions, this phase asks: "Before we spend six phases turning this into a build spec — is this the right thing at the right altitude?"

This is a product-level pressure test, not a technical review.

## The Three Questions

### Question 1: Is this the right problem?

Challenge the premise before challenging the solution.

- **What happens if we build nothing?** If the answer is "not much changes," the idea may not be worth the investment. If the answer is "users leave / revenue drops / a critical gap persists," the urgency is confirmed.
- **Is there a more direct path to the same outcome?** Sometimes the idea is right but the approach is indirect. A feature that solves the problem with 3 surfaces might be replaceable by a config change and a notification.
- **Are we solving a symptom or the root cause?** If users keep requesting "better export," maybe the real problem is that the data is hard to interpret in the first place.

Present findings as: "The premise holds because [evidence]" or "The premise has a weakness: [what and why]." Always with a recommendation.

### Question 2: Is this the right size?

Select one of four modes based on context. The agent recommends; owner decides.

**Expansion**
- Default for: greenfield products, new market entry, strategic pivots
- Posture: Dream first, cut later. What's the 10x version of this idea?
- Process: Present each potential expansion as an individual decision. Owner opts in or defers. No batching — each expansion gets its own discussion.
- Output: List of accepted expansions, deferred expansions (with rationale), and the revised scope.

**Selective Expansion**
- Default for: new surfaces, major capabilities, features that touch multiple systems
- Posture: Hold the core bulletproof, surface opportunities one by one.
- Process: Validate the settled concept is tight. Then present expansion opportunities individually. Owner cherry-picks.
- Output: Core concept confirmed + selected expansions added + deferred items documented.

**Hold Scope**
- Default for: small features, incremental additions, well-understood domains
- Posture: Confirm this is tight and move on. Challenge any bloat.
- Process: Walk the settled concept looking for unnecessary complexity. Is every piece earning its keep? Could anything be simpler?
- Output: Confirmation that scope is correct, or specific items flagged for removal.

**Reduction**
- Default for: oversized concepts that came out of the grill-me, features with unclear ROI, resource-constrained timelines
- Posture: Surgical minimalism. What's the minimum that ships value?
- Process: Rank every component of the settled concept by value-to-effort. Draw a line. Everything below the line gets deferred with documented rationale.
- Output: Minimum viable concept + deferred items with V2 tracking.

### Question 3: Is there a better version of this idea?

Forced alternatives. Not "different ways to implement the same thing" — different product approaches to the same problem.

Produce 2-3 distinct approaches:
- **Approach A:** [The settled concept, as-is]
- **Approach B:** [A fundamentally different product approach]
- **Approach C:** [Another alternative, if one exists]

For each:
- What does it prioritize?
- What does it sacrifice?
- Who does it serve best?
- What's the effort delta vs. Approach A?

Explicit recommendation with rationale. The settled concept (Approach A) may win — that's fine. The point is forcing the comparison so the owner chooses it deliberately, not by default.

## Outcomes

Three possible results:

1. **Confirmed** — The concept is right. Proceed to Phase 5 (Component Map) with no changes. Document: "Stress test passed. Concept confirmed as-is."

2. **Reshaped** — The concept changes. Document every specific change and why. If changes invalidate locked decisions from Phase 3 (Grill-Me), list which decisions need re-grilling and loop back to a targeted Phase 3 before proceeding.

3. **Killed** — The idea isn't worth building. Rare but valid. Document why, what was learned, and whether any component is worth salvaging for a different idea. Close it out.

## Adapting the Framework

These three questions and four modes are defaults, not liturgy. Adapt when the product context demands it:

- **If the concept is very small** (a config flag, a minor UI change), collapse the stress test into a single "does this need its own PRD or is it a story in an existing one?" question. Don't run three formal questions on a two-day feature.
- **If the owner already stress-tested externally** (board presentation, investor due diligence, customer interviews), skip Question 1 and focus on scope calibration and forced alternatives.
- **If a fifth mode makes sense for scope** — say, "Split" (break into two separate features) — use it. The four modes cover the common cases. Reality has more cases.
- **If the forced alternatives feel forced** — if there genuinely isn't a meaningfully different product approach — say so. Producing weak alternatives to fill a template wastes everyone's time. One strong alternative and an honest "I couldn't find a third that isn't a strawman" is better.

The goal is a deliberate decision to proceed, not a completed checklist.

## Artifact

Stress test summary containing:
- Mode selected and rationale
- Premise validation (Question 1 findings)
- Scope assessment (Question 2 — mode used, any changes)
- Alternatives considered (Question 3 — approaches compared, selection rationale)
- Final direction: Confirmed / Reshaped (with change list) / Killed (with rationale)
- Loop-back items: decisions from Phase 3 that need re-grilling (if reshaped)
