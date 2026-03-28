# Adversarial Review

Methodology for Phase 8. This is not a proofreading pass. This is an engineering-lead review: "Can I build exactly what this says without asking a single follow-up question?"

## Finding Categories

Six categories, three severity levels. Categories 1-3 are blockers — the PRD cannot ship with these unresolved. Categories 4-5 are warnings — they should be resolved but won't stop a build. Category 6 is editorial.

### 1. Direct Contradictions (Blocker)
The PRD says X in one place and Y in another, or the PRD says X and a connected document says Y.

**Examples:**
- Story 47 says "sort by date created" but the implementation section says "sort by last modified"
- The PRD assigns a feature to the Settings page, but the companion document places it on the Dashboard
- The permissions section says editors can access a feature, but Story 22 says it's admin-only

### 2. Cross-PRD Dependency Gaps (Blocker)
The PRD needs something from another document that the other document doesn't provide. Or the PRD provides something that no consuming document references.

**Examples:**
- The PRD references a config setting `alert_threshold` but the settings document doesn't define it
- The PRD consumes a data field `cancellation_reason` but the source data model doesn't include that field
- The PRD defines a new permission toggle but the permissions PRD has no corresponding story

### 3. Missing Specifications (Blocker)
An engineer would have to stop and ask a question to build this. Information that must exist for implementation but doesn't.

**Examples:**
- A feature has a threshold (e.g., "flag slow movers") but the threshold value isn't specified
- A data display has no specified sort order
- A time-based feature doesn't specify what time zone to use
- A conditional feature ("if X is enabled...") has no spec for the disabled state

### 4. Ambiguities (Warning)
Multiple valid interpretations exist. An engineer could reasonably build it two different ways.

**Examples:**
- "Recent transactions" — how recent? Last 24 hours? Last 7 days? Since last login?
- "Aggregate data across accounts" — sum? Average? Weighted average?
- "Show relevant metrics" — which ones? Who decides relevance?

### 5. Supersession Questions (Warning)
A source document defines features that this PRD should address (because it supersedes that area) but doesn't explicitly handle.

**Examples:**
- The source document defines reporting features (FR71-FR83) that this PRD supersedes, but 3 of those requirements have no corresponding story in the new PRD
- A feature from the source PRD is neither carried forward nor explicitly marked as out of scope
- The supersession boundary is ambiguous — both PRDs could claim ownership of a feature

### 6. Minor Gaps (Editorial)
Threshold values that could use confirmation, cross-reference notes that are slightly off, formatting inconsistencies, terminology that's correct but could be clearer.

**Examples:**
- A percentage threshold works but might not be optimal (5% vs 10% for flagging)
- A companion document reference uses an old filename
- Story numbering has a gap (jumps from 47 to 49)

## Audit Process

Run these three audits in sequence:

### 1. Internal Consistency Audit
Read the PRD end-to-end. Check:
- Do user stories match implementation decisions?
- Do visual assignments (cards, charts, tables, badges) match across sections?
- Are field names consistent within the document?
- Are permissions consistent between the permissions description and individual stories?
- Do edge cases in implementation decisions have corresponding stories?
- Does every component from the Solution section have stories?

### 2. Cross-Document Validation
For every document in the dependency tables, read it in full and check:
- Do field names match between documents?
- Do config settings referenced here exist in the source document?
- Do data model fields referenced here exist in the source data model?
- Are permissions models consistent across documents?
- Does terminology match exactly?
- Are the dependency tables themselves accurate and current?

### 3. Gap Detection
Look systematically for:
- Missing empty states (every surface needs one)
- Unspecified error handling at system boundaries
- Ambiguous "or" statements (which one is it?)
- Conditional features without fallback specs
- Features from source documents that should be addressed but aren't
- Claims that "every X does Y" that one X actually violates
- Time-based features without timezone or refresh specs
- Export features without column specs
- Aggregation features without rollup rules

## Compiling Findings

Format each finding using the template in `templates/adversarial_finding.md`. Number findings sequentially. Group by category.

Present to owner in order: all Blockers first (categories 1-3), then Warnings (4-5), then Editorial (6). Within each severity level, present in category order.

For each finding, lead with a recommendation. The owner decides, but the agent goes first.

## Adapting the Review

The six categories and three audits are the standard framework. Adapt when the PRD context demands it:

- **If the PRD has no companion documents** (first PRD for a new product), Cross-Document Validation (Audit 2) is minimal. Spend the time on Gap Detection instead — first PRDs tend to have more missing specs than contradictions.
- **If a finding doesn't fit cleanly into one category,** assign the closest one and note the overlap. The categories exist to organize the conversation with the owner, not to create classification debates.
- **If a finding is technically a Blocker but the owner has strong context for why it's acceptable,** the owner can downgrade it. Document the rationale. The severity levels guide prioritization — the owner makes the call.
- **If the PRD is very short** (under 20 stories), a single combined pass may be faster than three sequential audits. The audits are separate because large PRDs need structured coverage. Small PRDs need judgment.

The goal is zero unresolved questions an engineer would need to ask. The categories are a tool for getting there.

## Resolution Process

Walk findings one by one with the owner. For each:
1. Present the finding with evidence and recommendation
2. Owner decides: accept recommendation, modify, or override
3. Lock the resolution
4. Apply the change to the PRD immediately
5. Move to next finding

After all findings are resolved:
- Bump the PRD version
- Update the status line (e.g., "v2 — post-adversarial review, [N] findings resolved")
- Update the Last Updated date
