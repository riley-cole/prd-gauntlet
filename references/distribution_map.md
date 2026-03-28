# Distribution Map

Output routing framework for Phase 10 (Finalize & Distribute). Defines the categories of outputs and when each is triggered. Specific file paths and destinations come from the project config.

## Output Categories

### 1. Finalized PRD
Move the PRD to the project's designated PRD directory. If it was already there, confirm the file is current.

**Trigger:** Every PRD, every time.

### 2. Process Ledger and Reconciliation Pass
Store both companion artifacts alongside the PRD in the same directory:
- **Process Ledger:** `[prd_filename]_process_ledger.md` — the reasoning trail built across Phases 1-9
- **Reconciliation Pass:** `[prd_filename]_reconciliation_pass.md` — the detailed verification record from Phase 9

Both must be referenced in the PRD's Companion Documents table (Section 7). Both must be listed in the doc index.

**Trigger:** Every PRD, every time. These are not optional.

### 3. Stakeholder Deliverables
Identify and rebuild any formatted documents (PDFs, decks, briefs) that draw content from changed documents. This includes:
- Strategy documents (board/investor audience)
- Design briefs (design partner audience)
- Metric or data dictionaries (reference audience)
- Any other formatted deliverable that references content from the updated PRD or its connected docs

**Trigger:** Content change affects an external audience. Check the project config's distribution targets for specific deliverables and their destinations. See `templates/project_config.md` for the Distribution Targets schema.

**Process:**
1. List every deliverable that could be affected
2. For each, check if the underlying content changed
3. Rebuild only the affected deliverables
4. Copy to distribution folders per project config

### 4. Document Index
Update the project's document index with:
- New or updated version numbers
- Updated "Last Updated" dates
- Revised dependency mappings
- Updated story/requirement counts
- Updated "Last Validated" dates for dependency rows that were checked

**Trigger:** Always. Every finalization pass updates the index.

### 5. Open Items Tracker
Update the project's open items tracker:
- Close the PRD item (if it was tracked as an open item)
- Add any new items surfaced during the gauntlet (V2 candidates, deferred features, follow-up investigations)
- Update any items whose status changed as a result of this work

**Trigger:** Always.

### 6. Decision Log
Capture major decisions from the grill-me (Phase 3), stress test (Phase 4), and adversarial review (Phase 8).

A "major decision" is one that:
- Changes the product direction or scope
- Resolves a cross-document conflict
- Sets a precedent that future PRDs should follow
- Overrides a previous decision

**Trigger:** If decisions were made. Minor editorial fixes don't need logging.

## Checklist Before Declaring Complete

- [ ] PRD is in its final location with correct version and date
- [ ] Process ledger is stored alongside the PRD with correct filename and dates
- [ ] Reconciliation pass is stored alongside the PRD with correct filename and dates
- [ ] PRD's Companion Documents table references both the process ledger and reconciliation pass
- [ ] All affected deliverables are rebuilt and in their distribution folders
- [ ] Document index is current (versions, dates, dependencies, story counts) and includes the ledger and reconciliation pass
- [ ] Open items tracker reflects this session's work
- [ ] Decision log captures major decisions
- [ ] Owner confirms distribution is complete
