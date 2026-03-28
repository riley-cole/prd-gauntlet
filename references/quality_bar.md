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
- Short sentences, strong verbs, no filler
- Specific over general — always
- If a number exists, use it. "Most users" is weaker than "78% of users"
- Technical concepts in plain language — no jargon for jargon's sake
