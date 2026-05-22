# menno.codes — design handoff

Redesigns for two pages on the **menno.codes** Rails 8 portfolio:

- **`experience/`** — `/experience` page. Skill explorer with a ranked rail (sorted by years of experience) and a panel that splits each area's skills into "Top N primary" cards + an "Also used" chip row. Drops the per-skill progress bars.
- **`career/`** — `/jobs` page. Vertical accordion timeline with the rail moved to the right, year stamps in place of a date string, a lifted "Open to work" CTA banner above the timeline, and rarity-tier accents on each entry.

Each folder is self-contained and has its own `README.md`. Start there. The READMEs are written for a Claude Code session with the Rails repo open — they reference exact files in `app/views/`, `app/assets/stylesheets/`, and `app/javascript/controllers/`.

```
design_handoff/
├── README.md                  ← you are here
├── experience/
│   ├── README.md
│   ├── design_reference/      ← HTML/JSX prototype + extracted CSS
│   └── current_rails_source/  ← existing ERB / SCSS / Stimulus files to replace
└── career/
    ├── README.md
    ├── design_reference/
    └── current_rails_source/
```

## Both designs share

- The site's existing tokens (`_tokens.scss` / `colors_and_type.css`): yellow primary `#f5e90c`, deep navy backdrop, rarity ladder (legendary orange → epic purple → rare blue → uncommon green → common grey).
- The Anton / Anton SC / DM Sans / system-mono type stack.
- Sharp corners (radius `0`) for cards, `999px` pills for chips, no drop shadows.
- The body backdrop, navbar, and footer — those are unchanged by these handoffs.

## Recommended order

1. Read `design_handoff/experience/README.md` first — it's the smaller change.
2. Then `design_handoff/career/README.md`.
3. Each "What changes" table is the canonical diff against the current code.
