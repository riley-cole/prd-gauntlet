# Research Protocol

Optional research methodology for Phase 1 (Intake). Used when the ecosystem isn't well-enough understood from existing docs alone. Two independent research types that can run in parallel.

## When to Research

After loading existing project context, assess whether gaps exist in three areas:

1. **Competitive landscape** — Do we know who else operates in this space and how they approach the same problem? If not → external research.
2. **Customer signals** — Do we have evidence of what users actually want, complain about, or struggle with? If not → external research (public signals) or internal research (tickets/bugs).
3. **Internal patterns** — Does the product have accumulated operational data (bugs, support tickets, feature requests) that could inform this idea? If yes and unanalyzed → internal research.

If all three are well-covered by existing docs and project config, skip research entirely.

## External Research Agent

**Purpose:** Map the competitive and customer landscape from publicly available information.

**What to search:**
- Competitor websites: product pages, feature lists, pricing, positioning statements
- Review platforms: G2, Capterra, TrustRadius, app store reviews
- Community discussion: Reddit, forums, Hacker News, Stack Overflow, niche community sites
- Industry content: blog posts, case studies, market reports, conference talks
- Adjacent products: tools in the same ecosystem that this product could integrate with or compete against

**How to structure findings:**

1. **Competitive Map** — For each relevant competitor:
   - Name and positioning (one sentence)
   - Key features relevant to the idea being defined
   - Pricing model (if visible)
   - Strengths (what they do well)
   - Weaknesses (what users complain about)

2. **Customer Signal Synthesis** — Across all sources:
   - Top praised features in this category
   - Top complaints and pain points
   - Most requested features that don't exist yet
   - Patterns in how users describe the problem (their language, not marketing language)

3. **Market Trajectory** — Where is this category heading?
   - Emerging trends
   - Table stakes (what every product must have)
   - Differentiators (what separates leaders from followers)

4. **Positioning Opportunities** — Gaps no current player fills well

**Output format:** Structured landscape summary with sources cited. Every claim links back to a specific source (URL, review, thread).

## Internal Research Agent

**Purpose:** Mine internal systems of record for patterns that should inform the product idea.

**What to scan:**
- Bug trackers (Jira, Linear, GitHub Issues, Asana): tickets related to the product area
- Support tickets (Zendesk, Intercom, Freshdesk): customer-reported issues and requests
- Feature request logs: formal or informal tracking of what users have asked for
- Incident reports: outages, failures, escalations related to this area
- Internal docs: wikis, decision logs, retrospectives, past specs that touched this area

**How to structure findings:**

1. **Theme Clusters** — Group related issues into 5-10 themes. For each:
   - Theme name and description
   - Number of tickets/issues
   - Severity distribution (critical / major / minor)
   - Representative examples (3-5 specific tickets with summaries)

2. **Frequency Analysis** — What comes up most often? Rank themes by volume.

3. **Severity Analysis** — What causes the most pain? Rank themes by impact.

4. **Direct Relevance Map** — Which findings connect directly to the proposed idea?
   - Strong connection (this idea would directly address the issue)
   - Partial connection (this idea is adjacent)
   - Context only (useful background, doesn't change the idea)

**Access requirements:** The owner must provide one of:
- Direct system access (URL + credentials or API token)
- Exported data (CSV, JSON, or plaintext dump)
- Specific project keys or search queries to scope the research

## Agent Coordination

When both research types run in parallel:
- They operate independently — no dependency between internal and external agents
- Each produces its own structured report
- After both return, Claude synthesizes into a unified landscape view that feeds the ecosystem summary
- Conflicts between internal and external signals get flagged (e.g., "customers publicly praise feature X, but internal tickets show it breaks constantly")

## Quality Bar

Research findings must be specific and sourced. Generic summaries waste time and mislead product decisions.

**Useless:** "Competitors offer real-time analytics dashboards."

**Useful:** "Competitor A shows hourly usage by team with 15-minute refresh and lets admins set custom alerts. Competitor B shows daily totals only, updated at end of day. Neither offers role-based filtering or per-user breakdowns."

**Useless:** "Users want better reporting."

**Useful:** "14 of the top 20 G2 reviews for [competitor] mention reporting limitations. The most common complaint (7 reviews) is inability to export data by custom date range. Three reviews specifically mention needing per-user or per-team breakdowns."

Every finding should pass this test: "Could a product owner make a different decision based on this information?" If not, it's not worth including.
