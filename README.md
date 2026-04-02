# PRD Gauntlet

A Claude Code skill that takes a product concept from zero to a finalized, cross-validated build spec. Twelve phases from intake through distribution. A PRD is not done when you finish writing it — it's done when the entire system of documents agrees with it.

## What It Produces

Three documents that travel together:

- **PRD** — The build spec. What to build, why, and in what order.
- **Process Ledger** — The reasoning trail. Why it was built this way, what alternatives were considered, what was challenged.
- **Reconciliation Pass** — The verification record. Proof that the PRD is consistent with everything it touches.

## The Twelve Phases

| # | Phase | What Happens | Artifact |
|---|-------|-------------|----------|
| 0 | Workspace Setup | Scaffold project folder structure (first run only) | Project workspace + starter config |
| 1 | Intake | Load ecosystem context, directed questions, optional deep research | Ecosystem summary + process ledger |
| 2 | Define | Draft and lock problem statement, audience, scope | Product definition |
| 3 | Grill-Me | Walk every decision branch, lock each answer | Numbered decision log |
| 4 | Stress Test | Is this the right thing at the right size? | Confirmed/reshaped concept |
| 5 | Product Vision Brief | Bridge concept to execution — thesis, key moments, reference decomposition, design intent, scope/anti-scope | Vision brief |
| 6 | Strategic Council | Six independent advisors stress-test the strategy through distinct lenses, peer-review blind, synthesize into actionable findings | Council synthesis + updated vision brief |
| 7 | Component Map | Map every surface, data flow, integration point | Component map with connections |
| 8 | User Stories | Exhaustive coverage of every actor and edge case | Numbered story list |
| 9 | Draft PRD | Synthesize everything into a build spec | Complete PRD |
| 10 | Adversarial Review | Stress-test for gaps, contradictions, conflicts | Updated PRD, zero open findings |
| 11 | System Validation | Verify full document system consistency | Reconciliation pass, zero FAILs |
| 12 | Finalize | Package and distribute to stakeholders | Final PRD + companions + deliverables |

## Installation

### Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI installed and authenticated.

### Install the Skill

Clone this repo into your Claude Code skills directory:

```bash
# Navigate to your workspace (or wherever you keep Claude Code skills)
cd ~/.claude/skills  # or your preferred skills location

# Clone
git clone https://github.com/riley-cole/prd-gauntlet.git riley-prd-gauntlet
```

Or copy the skill folder directly into your project's `.skills/` directory:

```bash
cp -r prd-gauntlet /path/to/your/project/.skills/riley-prd-gauntlet
```

## Usage

### Start a New PRD

```
/riley-prd-gauntlet Start a new PRD for [your product idea]
```

If no project config exists, the gauntlet starts with Phase 0 (workspace setup). If a config exists, it jumps straight to Phase 1.

### Partial Entry Points

You don't have to run the full gauntlet every time:

| Command | What It Does |
|---------|-------------|
| `Start a new PRD` | Phase 0 or 1 depending on config |
| `Research [topic/market]` | Phase 1 research fork only |
| `Stress test [concept]` | Phase 4 (concept must be defined) |
| `Product vision brief` | Phase 5 |
| `Strategic council on [doc]` | Phase 6 (standalone on any vision brief) |
| `Adversarial review on [doc]` | Phase 10 |
| `Cross-PRD validation` | Phase 11 |
| `Finalize and ship` | Phase 12 |
| `Run the full gauntlet` | All phases, start to finish |

### Project Configs

For repeat projects, create a config file in `projects/` to give the gauntlet full context about your document ecosystem, terminology, companion docs, and distribution targets. See `projects/example-saas-app.md` for a complete example.

The first gauntlet run on a new project generates a starter config automatically. It gets richer with each subsequent run.

## Architecture

Two-layer design: universal methodology + project-specific configuration.

```
riley-prd-gauntlet/
├── SKILL.md                    # Orchestrator — phase flow, hooks, entry points
├── references/                 # Universal methodology (never project-specific)
│   ├── operating_rules.md      # Behavioral rules, questioning discipline
│   ├── gotchas.md              # Known failure patterns
│   ├── workspace_setup.md      # Phase 0 methodology
│   ├── product_vision_brief.md # Phase 5: guided extraction process
│   ├── strategic_council.md    # Phase 6: six advisors, peer review, synthesis
│   ├── prd_format.md           # PRD structure and section order
│   ├── quality_bar.md          # Quality standards, banned phrases, proof protocol
│   ├── research_protocol.md    # Phase 1 research agent methodology
│   ├── build_sequence.md       # Section 8: vertical slices, integration boundaries
│   ├── stress_test.md          # Phase 4: three questions, four modes
│   ├── adversarial_review.md   # Phase 10: finding categories, audit process
│   ├── reconciliation_checklist.md  # Phase 11: dynamic reconciliation engine
│   └── distribution_map.md     # Phase 12: output routing
├── templates/                  # Reusable artifact scaffolds
│   ├── prd_skeleton.md         # Blank PRD with all sections
│   ├── project_config.md       # Project config scaffold
│   ├── process_ledger.md       # Reasoning trail template
│   ├── adversarial_finding.md  # Finding format for Phase 10
│   ├── reconciliation_pass.md  # Verification checklist for Phase 11
│   └── phase_checklist.md      # Quick-reference for all phases
├── scripts/                    # Hook scripts (automated quality enforcement)
│   ├── proof-gate.sh           # Blocks writes to prds/ without proof protocol
│   ├── check-ledger-updated.sh # Reminds to update process ledger
│   └── log-phase-activity.sh   # Async activity logging
├── projects/                   # Project-specific configs
│   └── example-saas-app.md     # Example config (use as starting point)
└── evals/
    └── evals.md                # Test scenarios for each entry point
```

### How It Works

**Layer 1 (Methodology)** — The `references/` and `templates/` directories contain the universal engine. How to run each phase, what to check, what to produce. No project names, no file paths, no domain terminology.

**Layer 2 (Project Config)** — One file per project in `projects/`. Defines your document ecosystem, terminology standards, companion docs, distribution targets, and research sources. The richer the config, the more autonomous the gauntlet runs.

**Hooks** — Three automated hooks enforce quality during execution:
- **Proof gate** fires before any write to a `prds/` directory, enforcing the validation protocol.
- **Ledger check** fires after writing PRD artifacts, reminding to keep the process ledger current.
- **Activity logger** runs async after every markdown write, maintaining an audit trail.

## Key Concepts

**Product Vision Brief** — Phase 5 bridges concept (Phases 1-4) to execution (Phases 7-9). Seven rounds of guided extraction: Product Thesis, User and Their World, Key Moments, Reference Decomposition, Design Intent, Scope and Anti-Scope, Open Questions. Reference Decomposition cannot be skipped — it's where vague inspirations become actionable design direction.

**Strategic Council** — Phase 6 runs six independent advisors (Contrarian, First Principles, Expansionist, Outsider, User Advocate, plus a rotating sixth seat) against the Vision Brief. Advisors analyze independently, peer-review each other blind, and a chairman synthesis extracts actionable findings walked one at a time with the owner. The last strategic checkpoint before execution phases begin.

**Obligation tags** — During the grill-me (Phase 3), decisions that affect external artifacts get tagged with what they touch. These tags feed the reconciliation engine in Phase 11.

**NEW/MODIFY classification** — The component map (Phase 7) classifies each component. MODIFY components require reconciliation against the existing artifact. NEW components don't.

**Walking skeleton** — The first vertical slice in the Build Sequence is always the thinnest possible end-to-end path. Proves the architecture before investing in breadth.

**Dynamic reconciliation** — Phase 11 doesn't run a fixed checklist. It generates a custom checklist from the actual work done in Phases 1-10. Every check names the specific artifact, field, or behavior being verified.

## License

MIT
