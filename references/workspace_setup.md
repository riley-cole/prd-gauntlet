# Workspace Setup

Reference for Phase 0. When the gauntlet runs for the first time on a new project — no existing project config — this phase creates the workspace structure before any product work begins.

## Why This Exists

A PRD gauntlet produces a lot of artifacts: the PRD itself, a process ledger capturing the reasoning trail, a reconciliation pass proving system consistency, research findings, stakeholder deliverables, and a document index tying it all together. Without a designated home, these artifacts scatter — some on the Desktop, some in Downloads, some in a random folder that made sense at the time. Six months later, nobody can find the decision log that explains why the feature was shaped a certain way.

The workspace gives every artifact a home from the start. Everything the gauntlet produces for a project lands in one place, organized by purpose. The owner can move the entire workspace folder anywhere — into Dropbox, Google Drive, iCloud, a git repo — and it still works because internal references are relative.

## The Briefing

Before scaffolding, give the owner a brief orientation on what they're about to go through. This is especially important for first-time users who may not know the gauntlet's structure.

Cover these points conversationally (not as a wall of text):

1. **What this is.** A structured process for turning a product idea into a finalized build spec that an engineering team can execute against without follow-up questions. Eleven phases from concept to cross-validated document.

2. **What they'll get at the end.** Three documents that travel together:
   - The **PRD** — the build spec. What to build, why, and in what order.
   - The **Process Ledger** — the reasoning trail. Why it was built this way, what alternatives were considered, what was challenged.
   - The **Reconciliation Pass** — the verification record. Proof that the PRD is consistent with everything it touches.
   Plus any stakeholder deliverables (PDFs, briefs) and a document index tracking versions and dependencies.

3. **What they'll need to provide.** Their product idea (rough is fine), any existing documentation, and decisions along the way. The gauntlet is collaborative — the agent leads with recommendations, but the owner makes every call.

4. **Why we're setting up a workspace first.** Everything needs a home before we start producing artifacts. Takes about a minute. They tell us the project name and where they want the folder, and we build the structure.

## What to Collect

Two inputs from the owner:

1. **Project name** — Used for the folder name and config file. Should be short, lowercase, no spaces (use hyphens). Examples: `inventory-tool`, `customer-portal`, `mobile-app`.

2. **Workspace location** — Where the project folder should live. This can be:
   - A path they specify ("put it in ~/Projects/")
   - Their current working directory (default if they don't have a preference)
   - An existing folder they want the gauntlet to use (if they already have docs organized somewhere)

If the owner already has an existing folder with documents, don't force them to move everything. Create the workspace structure inside or alongside their existing folder and note where their source documents live in the project config.

## Workspace Structure

```
[project-name]/
├── prds/                     ← Finalized PRDs + process ledgers + reconciliation passes
├── research/                 ← Research findings (competitive landscape, internal signals)
├── deliverables/             ← Stakeholder outputs (PDFs, briefs, decks)
├── source_docs/              ← Input documents provided during intake
├── index.md                  ← Document index (versions, dates, dependencies)
└── project_config.md         ← Auto-generated during intake, grows over time
```

### Folder Purposes

**`prds/`** — The primary output directory. Every finalized PRD lands here, along with its two companion artifacts (process ledger and reconciliation pass). These three files share a naming convention:
- `[feature]_prd.md`
- `[feature]_prd_process_ledger.md`
- `[feature]_prd_reconciliation_pass.md`

Over time, this folder becomes the complete spec library for the project. The index tracks what's here and how documents relate to each other.

**`research/`** — Research outputs from Phase 1. If the owner runs competitive analysis or internal ticket mining, the structured findings live here. Named by topic and date: `[topic]_research_[YYYY-MM-DD].md`. This folder may stay empty if no research is needed — that's fine.

**`deliverables/`** — Formatted outputs for stakeholders who don't need the raw PRD. Board summaries, design briefs, strategy decks, exported PDFs. Anything that gets sent to someone outside the build team.

**`source_docs/`** — A place for the owner to put (or link to) the input documents they provide during intake: existing specs, design mockups, data dictionaries, competitive analyses they've already done, notes, prior art. The gauntlet reads from here but never writes to it. This is the owner's input, preserved as-is.

**`index.md`** — The document registry. Tracks every document in the workspace: filename, version, last updated date, dependencies, and validation status. Gets created during Phase 1, updated during Phase 12.

**`project_config.md`** — The project's configuration file. Auto-generated during Phase 1 intake from the owner's answers. Contains: project identity, document ecosystem, terminology standards, distribution targets, and companion doc references. On subsequent gauntlet runs, this file is what makes Phase 1 fast — the agent already knows the landscape. The config grows over time as new PRDs add companion docs and new terminology gets established.

## The Project Config

The config is generated, not hand-authored. During Phase 1 intake, every answer the owner gives builds a section of the config. By the end of intake, the config exists as a byproduct of the conversation.

Initial config (after first gauntlet run) will be sparse — just the basics:
- Project name and domain
- Who the PRD audience is
- What source documents exist
- Terminology patterns observed during intake

Rich config (after several gauntlet runs) accumulates:
- Full companion doc table with filenames and roles
- Established terminology standards
- Distribution targets for different stakeholder audiences
- Supersession rules between PRDs
- Research sources

The config uses the template at `templates/project_config.md`. See that file for the full schema.

## Conventions

These conventions are specific to workspace setup. For the full set of file conventions that apply throughout the gauntlet (including during drafting and finalization), see `operating_rules.md`.

**Relative paths.** All references within the workspace use relative paths. `prds/feature_prd.md`, not `/Users/someone/Projects/my-app/prds/feature_prd.md`. This means the workspace can be moved without breaking anything.

**Naming.** Files use lowercase with hyphens or underscores. No spaces. PRD filenames follow `[feature]_prd.md`. Companion artifacts append their type: `[feature]_prd_process_ledger.md`.

**Dates.** YYYY-MM-DD everywhere. In filenames, in document headers, in the index.

**Versioning.** PRD versions are tracked in the document header (`v1`, `v2`, etc.) and in the index. The file itself is always the current version — prior versions aren't preserved as separate files unless the owner specifically wants that.

## When to Skip Phase 0

Phase 0 only runs when no project config exists. If the owner has already been through the gauntlet for this project, the config exists and Phase 0 is skipped entirely. The gauntlet starts at Phase 1 with full context loaded from the config.

If the owner is entering at a later phase (e.g., "adversarial review on this doc"), and no config exists, run a lightweight version of Phase 0: create the workspace, generate a minimal config from whatever context is available, then proceed to the requested phase.
