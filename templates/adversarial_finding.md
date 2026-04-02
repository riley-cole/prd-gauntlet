# Adversarial Finding Template

Use this format for every finding during Phase 10 (Adversarial Review). Number findings sequentially. Group by category within severity level.

---

**Finding [N]** — [Category Name]
**Severity:** [Blocker / Warning / Editorial]
**Location:** [Document name, section, story number, or cross-reference]
**Issue:** [What's wrong — one clear sentence]
**Evidence:** [Specific text, field name, or behavioral conflict from the document(s)]
**Recommendation:** [Proposed resolution — the agent's recommendation, presented before the owner decides]
**Resolution:** [Locked answer after owner review — filled in during the walkthrough]

---

## Categories Reference

| # | Category | Severity | Description |
|---|----------|----------|-------------|
| 1 | Direct Contradictions | Blocker | PRD says X, another place says Y |
| 2 | Cross-PRD Dependency Gaps | Blocker | PRD needs something another doc doesn't provide |
| 3 | Missing Specifications | Blocker | Engineer can't build without an answer |
| 4 | Ambiguities | Warning | Multiple valid interpretations |
| 5 | Supersession Questions | Warning | Source doc features without disposition |
| 6 | Minor Gaps | Editorial | Thresholds, cross-refs, formatting |

## Presentation Order

1. All Blockers first (categories 1, 2, 3)
2. Then Warnings (categories 4, 5)
3. Then Editorial (category 6)

Within each severity level, present in category order.
