# Example SaaS App — Project Config

This is an example project config showing how a mature project with multiple PRDs, companion documents, and established terminology would configure the gauntlet. Replace the values with your project's specifics.

---

## Identity
- **Project:** example-saas-app
- **Product domain:** B2B project management platform for agencies
- **PRD audience:** Engineering team — building exactly what's specified
- **Author line:** [Your Name] / Claude
- **Stakeholders:** Engineering (build), Design (UX), Leadership (strategy)

## Document Ecosystem
- **Doc index:** `docs/product/INDEX.md`
- **PRD location:** `docs/product/prds/`
- **Source documents:** `docs/product/source_docs/`
- **Static references:** Core Platform PRD (`core_platform_prd.md`) — mature, rarely changes, treat as dependency

## Companion Documents

| Document | Filename | Role |
|----------|----------|------|
| Core Platform PRD | core_platform_prd.md | Project CRUD, user management, permissions (static reference) |
| Billing PRD | billing_prd.md | Subscription tiers, usage tracking, invoicing |
| Reporting PRD | reporting_dashboard_prd.md | Dashboard, charts, data export |
| API Reference | api_reference.md | Public API contract, endpoints, auth |
| Entity Model | entity_model.md | Data entities, relationships, ownership |
| Permissions Matrix | permissions_matrix.md | Role-based access, feature flags |

## Terminology Standards
- Use "workspace" not "organization" for the top-level container
- Use "member" not "user" for people within a workspace
- Feature flag keys use snake_case (e.g., `enable_advanced_reporting`)
- Entity IDs use UUID format
- API versions use `v1`, `v2` prefix format
- Use "story" for PRD requirements, not "requirement" or "feature request"

## Distribution Targets

| Output | Destination | Trigger |
|--------|-------------|---------|
| Finalized PRD | `docs/product/prds/` | Every PRD |
| Process Ledger + Reconciliation Pass | Same directory as PRD | Every PRD |
| Design Brief PDF | `docs/design/briefs/` | Design-impacting changes |
| API Changelog | `docs/api/CHANGELOG.md` | API contract changes |
| INDEX.md | `docs/product/INDEX.md` | Always |

## Voice & Style
- Professional but direct
- No marketing language in specs
- Technical concepts in plain language
- Date format: YYYY-MM-DD

## Supersession Rules
- Reporting PRD supersedes Core Platform PRD sections on dashboard and data export
- Core Platform retains ownership of project CRUD, user management, workspace settings
- Billing PRD owns all subscription and payment surfaces

## Research Sources
- **Internal systems:** Linear (issue tracker), Intercom (support tickets), Notion (internal wiki)
- **External competitors:** Asana, Monday.com, ClickUp, Basecamp
- **Customer context:** Mid-size agencies (10-50 people), project-based work, client-facing deliverables
- **Market context:** Crowded project management space — differentiation through agency-specific workflows
