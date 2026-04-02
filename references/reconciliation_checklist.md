# Reconciliation Engine

Dynamic reconciliation methodology for Phase 11 (System Validation). Instead of running a fixed checklist, this engine generates a custom checklist from the actual work done in Phases 1-10. Every check is specific to what was built, references the actual artifact it touches, and tells you exactly what to verify.

Use `templates/reconciliation_pass.md` to record results.

## How the Engine Works

### Step 1: Collect Touchpoints

Gather every external artifact this PRD could affect. Three sources:

**Source A — Decision Log Obligation Tags (Phase 3)**
Every decision tagged with an external obligation becomes a touchpoint. The tag should include: what artifact it touches, where that artifact lives, and what the current state is.

Example: "Decision 14: Changed notification delivery from batch to real-time → touches `notification_service.py` (line 247, processes notifications in batch) and `notification_policy.md` (Section 3, describes batch delivery rules)"

**Source B — PRD Dependency Tables (Phase 9)**
Every row in the "Consumes" and "Provides" tables is a touchpoint. The PRD explicitly declares what it reads from and writes to.

Example: "Consumes `user.permission_level` from Auth Service schema" / "Provides `analytics_summary` event to the notification queue"

**Source C — MODIFY Components (Phase 7)**
Every component classified as MODIFY in the component map is a touchpoint. Something already exists and this PRD changes it.

Example: "MODIFY: Dashboard view — currently shows 3 summary cards, PRD adds 2 more cards and changes the layout"

### Step 2: Resolve Each Touchpoint

For every touchpoint collected, read the actual artifact. Understand its current state. This means:

- **Documents:** Read the file. Note the version, relevant sections, field names, terminology, and behavioral specs.
- **Code files:** Read the file (or relevant sections). Note the current implementation, data structures, function signatures, and behavioral logic.
- **API contracts:** Read the spec or the actual endpoints. Note request/response shapes, status codes, and error handling.
- **Configs/schemas:** Read the current config or schema definition. Note field names, types, defaults, and constraints.
- **External services:** Review the integration documentation. Note the contract, expected inputs/outputs, and error modes.

If an artifact can't be read (no access, doesn't exist yet), flag it as UNRESOLVED and note what's needed from the owner.

### Step 3: Generate Checks

Two types of checks are generated: touchpoint checks (specific to each touchpoint) and integrity checks (scoped to the terms and fields this PRD uses).

#### Touchpoint Checks

For each resolved touchpoint, generate a check using this format:

```
**[Touchpoint source] → [Artifact name]**
What changed: [specific change from the PRD]
Current state: [what the artifact currently says/does]
Check: [specific question to verify — is the artifact still compatible, or does it need updating?]
```

Example:
```
**Decision 14 → notification_service.py**
What changed: Notification delivery changed from batch to real-time
Current state: notification_service.py sends notifications in hourly batches (send_batch() on line 247)
Check: Does notification_service need a new send_realtime() method, or does the existing method need a delivery_mode parameter?
```

Example:
```
**Dependency table → Auth Service schema**
What changed: PRD references a "manager" role for report access
Current state: Auth Service defines permission_level as enum [admin, member]
Check: Does the Auth Service need a "manager" value added to the permission_level enum?
```

Example:
```
**MODIFY component → export_handler.js**
What changed: PRD introduces 2 new export formats (PDF summary, CSV detail)
Current state: export_handler supports 3 formats (JSON, XML, plain text)
Check: Does the handler need new formatters for PDF and CSV? Are the column/field mappings defined for each?
```

#### Integrity Checks

After generating touchpoint checks, scan across all resolved artifacts for system-wide consistency. These checks are scoped to the specific fields, terms, permissions, and identifiers this PRD actually uses — not a generic sweep.

**Field name consistency:** For every field name defined or referenced in the PRD, verify it uses the exact same string in every artifact that touches it. List the specific fields to check.

**Terminology consistency:** For every domain term established in the PRD (or in the project config's terminology standards), verify it's used uniformly. List the specific terms to check.

**Permission consistency:** For every permission grant or restriction in the PRD, verify it agrees with how that permission is defined in the source-of-truth artifact. List the specific permissions to check.

**Identifier consistency:** For every structured identifier in the PRD (feature IDs, entity IDs, status codes, error codes), verify the format and meaning match across artifacts. List the specific identifiers to check.

**Cross-reference accuracy:** For every filename, section reference, or story number cited in any artifact, verify it resolves to a real thing. List the specific cross-references to check.

Each integrity check should name the specific items being verified, not just the category. "Check that field names match" is too vague. "Check that `created_at`, `order_total`, and `permission_level` use the same name in the PRD, the data model, and the API contract" is actionable.

### Step 4: Run the Generated Checklist

1. Present the full generated checklist to the owner before running it. This lets the owner add checks the agent missed or remove checks that don't apply.
2. Run each check. For each: PASS (consistent, no changes needed), FAIL (inconsistency found, describe it), or UNRESOLVED (can't verify, describe what's needed).
3. For each FAIL: describe exactly what needs to change and in which artifact.
4. Fix all FAILs. Re-run affected checks to confirm PASS.
5. Zero FAILs and zero UNRESOLVED before proceeding to Phase 12.

## What Makes a Good Check

**Specific:** Names the exact artifact, field, term, or behavior being verified. Not "check permissions are consistent" but "check that the 'manager' role referenced in Story 34 exists in the Auth Service's permission_level enum."

**Traceable:** Links back to the source — which decision, dependency row, or component triggered this check.

**Actionable:** The check's answer leads directly to an action. If it FAILs, you know exactly what to change and where.

**Falsifiable:** It's possible for the check to fail. "Is the system consistent?" is not falsifiable. "Does `notification_service.py` support real-time delivery?" has a clear yes or no answer.

## What the Engine Needs from Earlier Phases

This engine depends on structured outputs from earlier phases. If these outputs are missing or incomplete, the generated checklist will have gaps.

| Phase | What It Must Produce | Used By |
|-------|---------------------|---------|
| Phase 1 (Intake) | Artifact catalog — every doc, code file, service, config, and external integration in the ecosystem | Touchpoint resolution |
| Phase 3 (Grill-Me) | Decision log with obligation tags — what external artifact each decision touches, where it lives, current state | Touchpoint collection |
| Phase 6 (Strategic Council) | Council findings log — accepted revisions, rejected findings with rationale, strategic assumptions validated or challenged | Cross-reference validation |
| Phase 7 (Component Map) | NEW/MODIFY classification for each component — MODIFY components reference the existing artifact | Touchpoint collection |
| Phase 9 (Draft PRD) | Dependency tables (consumes/provides) and Build Sequence integration boundaries | Touchpoint collection |

If a phase didn't produce the required output (e.g., intake didn't catalog code because there was no codebase), the engine works with what's available. It doesn't fail — it just has fewer touchpoints to check.

## Adapting the Engine

The four-step process (collect, resolve, generate, run) is the standard methodology. Adapt when the project context demands it:

- **If the ecosystem is tiny** (one PRD, no companion docs, no codebase), the engine generates few touchpoint checks. That's correct — don't invent checks to fill a template. Focus integrity checks on internal consistency.
- **If a touchpoint artifact has changed since you last read it** (someone edited it during the gauntlet), re-read it before running the check. Stale reads produce false PASSes.
- **If the owner identifies checks the engine missed** (business rules, compliance requirements, contractual obligations that aren't in any artifact), add them. The engine generates the mechanical checks. Human judgment catches what automation can't.
- **If a FAIL is debatable** (the PRD and the external artifact disagree, but both interpretations are defensible), present both interpretations to the owner. The owner decides which artifact to update. Document the rationale.

The goal is a system that agrees with itself. The engine is how you get there, not the definition of "there."

## Edge Cases

**No external artifacts exist (brand new product, no code, one document):** The engine has few or no touchpoints. Integrity checks still run on the PRD's internal consistency. This is fine — the engine scales down naturally.

**Massive ecosystem (50+ documents, large codebase):** Focus touchpoint resolution on artifacts that are directly referenced by obligation tags, dependency tables, or MODIFY components. Don't scan the entire codebase — only the parts the PRD actually touches.

**Artifact can't be read (no access, private repo, external service):** Mark the touchpoint as UNRESOLVED. Document what access is needed. The owner either provides access or accepts the risk of an unchecked touchpoint.

**Owner adds manual checks:** After reviewing the generated checklist, the owner may add checks the agent missed — business rules, contractual obligations, compliance requirements that aren't in any artifact. These are valid checks and get the same PASS/FAIL treatment.

## Multi-PRD Reconciliation

When multiple PRDs share a product ecosystem, Phase 11 expands from per-PRD validation to cross-system reconciliation. The engine methodology is the same — collect touchpoints, resolve artifacts, generate checks, run the checklist — but the scope is wider.

### When to Run Cross-System Reconciliation

- Two or more PRDs reference each other in dependency tables
- A change to one PRD could invalidate decisions in another
- A shared reference document (metric dictionary, entity model) has been updated since the last per-PRD review

### How It Differs from Per-PRD Reconciliation

**Scope:** Load ALL PRDs and shared reference documents simultaneously. The "artifact" being checked is the full system, not a single document.

**Touchpoint sources expand:**
- Per-PRD sources (obligation tags, dependency tables, MODIFY components) still apply
- Add: cross-PRD dependency tables from every PRD
- Add: shared reference documents (metric dictionaries, entity models, config schemas)
- Add: Build Sequence cross-PRD dependencies (Prerequisites, Unlocks, Dependencies)

**Check categories expand:**
- All per-PRD integrity checks still apply
- Add: terminology consistency across ALL PRDs (same field name, same role name, same metric name everywhere)
- Add: data flow consistency (if PRD A says it provides X to PRD B, does PRD B's dependency table say it consumes X from PRD A?)
- Add: permission model consistency (do all PRDs agree on who can see/do what?)
- Add: Build Sequence dependency bidirectionality (every Unlocks has a matching Dependencies, and vice versa)

### Parallel Agent Pattern

For systems with 3+ PRDs, run reconciliation with parallel agents:
1. Split the system into overlapping pairs (A↔B, B↔C, A↔C)
2. Each agent checks one pair in depth
3. Deduplicate findings across agents
4. Walk findings one by one with the owner — same resolution process as per-PRD

### Artifact

The reconciliation pass for a multi-PRD system is a single cross-system document (not per-PRD). It records: all documents validated, all findings by severity, all resolutions, and all new decisions locked. Stored alongside the PRDs.
