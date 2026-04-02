# Quality Bar

Universal quality standards for any PRD produced by this skill. These apply regardless of project, product, or audience. For behavioral rules governing how the agent operates throughout the gauntlet (response posture, questioning discipline, file conventions), see `operating_rules.md`. This file covers what the artifact must achieve — `operating_rules.md` covers how the agent should behave while building it.

## Spec Completeness

- Every user story must be implementable without further clarification from the product owner
- Every edge case must have an explicit resolution — no "handle appropriately" or "use best judgment"
- No "TBD" in a finalized PRD — resolve it or move it to Out of Scope with a rationale
- Every conditional feature must have a fallback spec (what happens when the condition isn't met?)
- Every surface must have an empty state specification
- Every system boundary must have error handling specified

## Cross-Document Consistency

- Cross-references to other documents use filenames, not assumptions
- Field names, metric IDs, config keys, and terminology must match exactly across all connected documents
- If Document A says a field is called `max_retry_count`, every document that references it uses that exact name
- Permissions described in the permissions section must match permissions referenced in individual stories
- Data model fields referenced in stories must exist in the data model section

## Proof Protocol

Full validation loop before presenting any artifact to the owner:

1. Re-read the entire artifact end-to-end
2. Verify all cross-references resolve (filenames exist, field names match)
3. Check story numbers are continuous and none are missing
4. Confirm implementation decisions don't contradict user stories
5. Verify Out of Scope items aren't accidentally covered by stories
6. Check dependency tables match what the PRD actually consumes/provides

Do not present a draft until this loop is complete. If you find issues during the loop, fix them first.

## Banned Phrases

These are dead AI language patterns. Fatal in any external deliverable. Remove on sight.

**Banned words:** Leverage, Solutions, Empower, Seamless, Innovative, Straightforward, Robust, Game-changer, Utilize, Harness, Landscape, Delve

**Banned patterns:**
- "In today's..."
- "It's important to note..."
- "This isn't X. This is Y." (negation-then-assertion — delete the negation, state the positive claim directly)
- "Furthermore / Additionally / Moreover / Moving forward"

**Weasel words (replace with data or cut):**
- "Significant improvement" / "significantly better" / "significantly reduced"
- "Nearly all" / "most" / "many" / "a number of" / "several"
- "Would help" / "might bring" / "should result in" / "could improve"
- "Arguably" / "relatively" / "fairly" / "quite"
- "Low latency" / "high performance" / "fast" (without a number)

**Word swaps:**
- Leverage → Use
- Solutions → Tools
- Empower → Give
- "will be able to" → "can"
- "We are committed to" → "We"
- Seamlessly → (cut it)
- Innovative → (show it, don't say it)

## Writing Standards

- Professional but not stiff
- Short sentences (30-word ceiling), strong verbs, no filler
- Subject-verb-object as default structure. Who does what. No passive voice burying the actor.
- Specific over general — always
- Replace adjectives with data. "Most users" is weaker than "78% of users." "Fast response time" is nothing. "p95 response under 200ms" is something.
- No weasel words. "Significant," "nearly all," "arguably," "should result in" — these are not specifications. They're placeholders for thinking you haven't done. Replace with a number or cut the sentence.
- Technical concepts in plain language — no jargon for jargon's sake
- The so-what test applies to every section. If a reader can't tell why this section exists and what it means for implementation, it's not done.
- Supporting context that isn't core to the spec goes in an appendix or companion doc, not inline. PRDs get bloated when every data point lives in the body.
