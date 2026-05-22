# Handoff: Experience page redesign

## Overview

This is a redesigned `/experience` page for **menno.codes** — the personal portfolio Rails app. The goal of the redesign is to lean harder into the site's existing **loot-rarity** visual metaphor on this page and to drop the somewhat noisy per-skill progress-bar UI in favour of a cleaner, more confident skill presentation.

The page lists the user's **experience areas** (Back-end Development, Full-Stack, DevOps & Automation, Cloud & Infrastructure, Microservices, iOS & macOS). For each area, the visitor sees how many years of experience the user has and which technologies that area pulls in.

## About the design files

The files in `design_reference/` are **design references built in HTML/JSX** — they are a prototype showing the intended look and behavior of the redesigned page. They are **not production code to copy verbatim**.

Your task is to **recreate this design inside the existing Rails 8 codebase** (`website/`), using its established patterns:
- Server-rendered ERB templates (`app/views/experience/show.html.erb`)
- SCSS partials in `app/assets/stylesheets/` compiled via `dartsass-rails`
- Stimulus controllers in `app/javascript/controllers/` for any client-side state
- i18n strings in `config/locales/{en,nl,de}.yml`
- Design tokens already declared in `app/assets/stylesheets/_tokens.scss`

For convenience, `current_rails_source/` contains the **existing** Rails files for this page (the ones you will be replacing). Use them to understand what's already there and what needs to change.

## Fidelity

**High-fidelity.** Exact colors, typography, spacing, and component structure are documented below and present in the reference files. The dev should aim for pixel-parity with the prototype, then adapt it to the real ERB/SCSS/Stimulus environment.

## What changes from the current page

| Aspect | Current (`current_rails_source/`) | Redesign (`design_reference/`) |
| --- | --- | --- |
| Rail row | `[icon] [name] [years] [chevron]` | `[2-digit rank] [name + year-bar] [chevron]` |
| Active rail accent | 3px left edge in rarity color | Same — kept |
| Panel header | `NAME` + huge `5.5rem` year numeral on the right | `NAME` set on a 160° rarity gradient paint-stroke (`exp-title-stroke`) — years moved into the description line |
| Years presentation | Large standalone numeral | Inline: `<strong>8 years of experience</strong> — {description}` |
| Skill presentation | Every skill is one row with a per-skill progress bar (33 / 66 / 100% by familiar / proficient / expert) | First 3 skills become **"primary" skill cards** (big devicon + name + description). The rest become **"also used" chip pills**, each in the technology's brand color. **All progress bars removed.** |
| Skill grouping headers | One header: `SKILLS · ORDERED BY PROFICIENCY` + total count | Two headers: `TOP {n} · PRIMARY` and `ALSO USED` |
| Sort order of skills inside a panel | Sort by `skill.level` descending | **Keep author/CONTENT_DATA order** (already "most relevant first") |
| Sort order of panels in the rail | CONTENT_DATA order | Sort by `years_of_experience` desc (so legendary > epic > rare > uncommon naturally falls out) |

The rail still drives tab selection; the panel still shows the active experience area. The page still uses the existing tokens (rarity colors, fonts, body backdrop). Nothing about the site's outer chrome (navbar, footer, body gradient) changes.

## Screens / Views

There is **one screen**: `/experience` (route: `experience#show`).

### Layout

```
┌─────────────────────────────────────────────────────────────────┐
│  H1  "Experience"                  (page-h1, yellow paint-stroke)│
│  H2  "What I've been doing"        (Anton SC)                    │
│                                                                  │
│  ┌──────────────┐   ┌──────────────────────────────────────────┐│
│  │  exp-rail    │   │  exp-panel                               ││
│  │              │   │                                          ││
│  │ 01 Full-Stack│   │  ┌──────────────────────────────────┐    ││
│  │ ▔▔▔▔▔▔▔▔▔▔ ›│   │  │ FULL-STACK DEVELOPMENT (stroke)  │    ││
│  │              │   │  └──────────────────────────────────┘    ││
│  │ 02 Back-end  │   │                                          ││
│  │ ▔▔▔▔▔▔▔▔▔  ›│   │  10 years of experience — front to back, ││
│  │              │   │  from database schema to the button …    ││
│  │ 03 DevOps    │   │                                          ││
│  │ ▔▔▔▔▔     › │   │  TOP 3 · PRIMARY                         ││
│  │              │   │  ┌─────────┐ ┌─────────┐ ┌─────────┐     ││
│  │ 04 Cloud     │   │  │ [icon]  │ │ [icon]  │ │ [icon]  │     ││
│  │ ▔▔▔     ›    │   │  │ Rails   │ │ JS      │ │ Vue.js  │     ││
│  │              │   │  │ desc…   │ │ desc…   │ │ desc…   │     ││
│  │ 05 Micros.   │   │  └─────────┘ └─────────┘ └─────────┘     ││
│  │ ▔▔▔     ›    │   │                                          ││
│  │              │   │  ALSO USED                               ││
│  │ 06 iOS/macOS │   │  [ts] [Node.js] [Postgres]               ││
│  │ ▔▔    ›      │   │                                          ││
│  └──────────────┘   └──────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────┘
```

### Outer container

- `<section class="section container">` — uses the existing `.section` (4rem block padding) + `.container` (max-width 1280px) shells.
- `h1.page-h1` — existing class, yellow paint-stroke clipped to the text width via `box-decoration-break: clone`.
- `h2` — sentence-case subtitle, already styled by `_typography.scss` as Anton SC.
- The two columns sit in `.exp-row`: `grid-template-columns: 340px 1fr; gap: 48px;`. **Note:** the current code uses `320px`; the redesign uses `340px`.

### Rail (`.exp-rail`)

A vertical list of buttons, one per experience area. Sorted by `years_of_experience` descending.

Each row (`.exp-rail .row`):
- Grid: `24px | 1fr | auto`, gap `12px`, padding `18px 14px 18px 16px`
- Border-top `1px solid var(--color-border)`; the last child also gets a border-bottom
- Left edge: a `3px` strip at `left: -3px` painted in the row's rarity color (`--row-color`), starts with `transform: scaleY(0)` and animates to `scaleY(1)` on `:hover` / `.active`
- On hover/active, padding-left grows from `16px → 22px`, background → `rgba(255,255,255,0.02)`
- Type: Anton, weight 800, `1.25rem`, uppercase, letter-spacing `0.02em`

Columns inside each row:
1. **Rank** — `.rank`: 2-digit, zero-padded (`01`, `02`, …), monospace, `0.65rem`, `--color-text-faint`. When the row is `.active`, color switches to `var(--row-color)` (the rarity accent).
2. **Label column** (`.label-col`) — vertical flex, gap `6px`:
   - `.name` — the area name, inherits the row's Anton 800 / uppercase / `1.25rem` styling; ellipsis if it overflows.
   - `.year-bar` — a `3px`-tall bar, `width: 100%`, background `rgba(255,255,255,0.06)`. Inside it, an `<i>` fill element painted in `--row-color`, width set inline to `(years / maxYears) * 100%`. Opacity `0.5` by default, `1.0` on `:hover` / `.active`. Width transitions `0.4s cubic-bezier(.2,.7,.2,1)`.
3. **Chevron** — `›`, Anton 900, `1rem`, `--color-text-faint`. Turns yellow (`var(--color-primary)`) when the row is active.

Per-row CSS custom property `--row-color` is set inline based on the experience's rarity accent:
- `legendary` → `var(--color-legendary)`
- `epic` → `var(--color-epic)`
- `rare` → `var(--color-rare)`
- `uncommon` → `var(--color-uncommon)`
- `common` → `var(--color-common)`

### Panel (`.exp-panel`)

The detail view for the active experience area. Translucent card on the body backdrop.

- Background: `rgba(255,255,255,0.02)`
- Padding: `28px 30px`
- **No top accent border** in the redesign (the current page has `border-top: 4px solid var(--panel-color)` — drop it; the paint-stroke on the title carries the rarity color now).
- Two CSS custom properties set inline on the panel root:
  - `--panel-color: var(--color-{accent})` — used by the chevron color override etc.
  - `--panel-grad: linear-gradient(160deg, var(--highlight-{accent}-from) 0%, var(--highlight-{accent}-mid) 50%, var(--highlight-{accent}-to) 100%)` — used as the background of `.exp-title-stroke`.

**Panel header** (`.exp-panel-header`):
- Margin-bottom + padding-bottom `1.25rem`, bottom hairline `1px solid var(--color-border)`.
- Single `<h2>` (no separate year stamp), font-size `clamp(1.5rem, 2.6vw, 2.25rem)`, line-height `1`, margin `0`.
- The text is wrapped in `<span class="exp-title-stroke">`:
  - `display: inline; color: #fff; padding: 0.04em 0.18em;`
  - `-webkit-box-decoration-break: clone; box-decoration-break: clone;` — so the paint-stroke clones across line wraps
  - `background: var(--panel-grad);` — the 160° rarity gradient
- Text content is the experience name in `.toUpperCase()`.

**Description** (`.exp-panel-desc`):
- `font-size: 0.95rem; line-height: 1.7; color: var(--color-text-muted); max-width: 56ch; margin: 0 0 1.5rem;`
- Inline year stamp at the start: `<strong>{years} years of experience</strong> — {description}`
- `.exp-panel-desc strong { color: var(--color-text); font-family: var(--font-display); font-weight: 700; font-size: 1rem; }` — Anton numeral pop, on the same line as the rest of the copy.

**Skill group header** (`.exp-skills-header`):
- `display: flex; align-items: baseline; justify-content: space-between;`
- Font: mono, `0.62rem`, uppercase, letter-spacing `0.08em`, color `--color-text-faint`.
- Top margin `1.75rem`, except the first one in the panel (`.exp-skills-header:first-of-type { margin-top: 0; }`).
- Bottom margin `0.75rem`, gap `1rem`.
- Contains a single `<span>`: `TOP {n} · PRIMARY` (where `n` is `min(3, skill_count)`) or `ALSO USED`.

**Primary skill cards** (`.sk-primary`):
- Grid: `repeat(3, 1fr)`, gap `14px`. Collapses to a single column at `max-width: 720px`.
- Each card `.sk-card`:
  - `display: flex; flex-direction: column; gap: 10px; padding: 18px;`
  - Background `rgba(255,255,255,0.03)`, border `1px solid color-mix(in srgb, var(--chip-c) 35%, transparent)`
  - `--chip-c` is set inline to the skill's `accent` hex (e.g. Ruby `#CC342D`).
  - Hover: `transform: translateY(-2px); background: rgba(255,255,255,0.06)` over `0.2s ease`.
- Card contents (in order):
  1. `<i class="icon devicon-…-plain">` — `2.4rem`, color `color-mix(in srgb, var(--chip-c) 90%, transparent)`, line-height `1`.
  2. `.name` — Anton 700, `1.5rem`, uppercase, letter-spacing `0.01em`, color `--color-text`.
  3. `.desc` — body font, `0.78rem`, line-height `1.55`, color `--color-text-muted`, margin `0`.

**Secondary chip pills** (`.sk-secondary`):
- `display: flex; flex-wrap: wrap; gap: 0.4rem;`
- Each `.sk-chip`:
  - `display: inline-flex; align-items: center; gap: 0.4em;`
  - `padding: 0.35em 0.8em; border-radius: 999px;`
  - Mono font, `0.65rem`, uppercase, letter-spacing `0.06em`, color `--color-text`.
  - Background `color-mix(in srgb, var(--chip-c) 8%, transparent)`
  - Border `1px solid color-mix(in srgb, var(--chip-c) 35%, transparent)`
  - `--chip-c` set inline to the skill's accent hex.
  - Inner `<i>` (devicon) — `0.95rem`, `flex-shrink: 0`.
  - `title` attribute set to the skill's description (browser tooltip).

### Responsive

`@media (max-width: 900px) { .exp-row { grid-template-columns: 1fr; } }` — the rail stacks above the panel on narrow viewports.

`@media (max-width: 720px) { .sk-primary { grid-template-columns: 1fr; } }` — primary cards stack.

## Interactions & Behavior

- **Tab interaction.** Clicking a rail row activates that area. Add `.active` to that row, remove from siblings. Update the panel content. Existing Stimulus controller in `current_rails_source/experience_controller.js` handles the show/hide pattern with `hidden` attributes — keep the same pattern but render only **one** panel inside the active state if you prefer (the React prototype uses a single panel and swaps content; either approach is fine).
- **Default selection.** The topmost row by years (the first one in the sorted list) is active on initial render.
- **Keyboard.** Rail rows are `<button>`s — already focusable, already activate on `Enter`/`Space`. The existing `role="tablist"` on the rail and `role="tab"` on rows can stay; add `aria-selected="true|false"`.
- **Hover / active transitions.** As documented per-component above. All `0.2s ease` unless otherwise noted. The year-bar fill width uses `0.4s cubic-bezier(.2, .7, .2, 1)`.
- **Focus.** Inherits the global `outline: 2px solid var(--color-primary); outline-offset: 2px` from `_base.scss`. No additional focus styling needed.
- **No animation on panel swap.** The active panel content just updates. Keep it crisp; no slide-in or fade.

## State Management

In Rails terms, the existing Stimulus controller (`experience_controller.js`) handles client state:
- `targets: ['row', 'panel']`
- `select(event)` reads `data-experience-key` from the clicked row and toggles the matching panel.

Suggested updates for the redesign (keep server-rendered to stay consistent with the rest of the app):
- Pre-render **all** panels server-side with `hidden` attributes, like the current implementation.
- Set the first row `aria-selected="true"` and remove `hidden` from its matching panel on initial render.
- On `click`, the Stimulus controller switches which panel has `hidden`, toggles `aria-selected` and the `.active` class on rows, and sets the rail row's `--row-color` (already set inline server-side — no JS needed).
- Compute `maxYears` once in the controller (Ruby) for the year-bar widths — pass it to the partial.

## Design Tokens

All values come from the existing `app/assets/stylesheets/_tokens.scss`. Do not invent new ones. The relevant tokens used by this page:

### Colors

| Token | Hex (dark) | Use |
| --- | --- | --- |
| `--color-primary` | `#f5e90c` | Active chevron, focus ring |
| `--color-text` | `rgba(255,255,255,0.92)` | Body copy strong, card names |
| `--color-text-muted` | `rgba(255,255,255,0.7)` | Descriptions |
| `--color-text-faint` | `rgba(255,255,255,0.55)` | Mono meta labels, rail rank, chevron |
| `--color-border` | `rgba(255,255,255,0.10)` | Rail row dividers, panel header divider |
| `--color-legendary` | `#FF8000` | Rail accent + panel paint-stroke gradient start |
| `--color-epic` | `#A335EE` | … |
| `--color-rare` | `#0070DD` | … |
| `--color-uncommon` | `#1EFF00` | … |
| `--color-common` | `#9D9D9D` | … |
| `--highlight-{tier}-{from,mid,to}` | (see tokens) | The 3-stop gradient used in `--panel-grad` |

Per-skill devicon brand colors live on each skill record in `CONTENT_DATA.yml` (`Ruby #CC342D`, `Rails #CC0000`, etc.) and are passed inline as `--chip-c`.

### Typography

| Token | Family | Use |
| --- | --- | --- |
| `--font-display` | Anton | Rail row labels, card names, panel title, year-stamp `<strong>` |
| `--font-body` | DM Sans | Description copy |
| `--font-mono` | `ui-monospace, Cascadia Code, Fira Mono, …` | Rail rank, skill-group headers, chip pill labels |

Type scale (this page):

- Page h1: `clamp(3rem, 7vw, 5rem)` (existing `.page-h1`)
- Page h2: existing default
- Panel h2: `clamp(1.5rem, 2.6vw, 2.25rem)`, line-height `1`
- Rail row name: `1.25rem`
- Card name: `1.5rem`
- Card description: `0.78rem`
- Panel description: `0.95rem` / line-height `1.7`
- Skill-group header: `0.62rem` mono uppercase, tracking `0.08em`
- Chip pill: `0.65rem` mono uppercase, tracking `0.06em`
- Rail rank: `0.65rem` mono, tracking `0.04em`

### Spacing

- `.exp-row` gap: `48px`
- Rail row padding: `18px 14px 18px 16px` (left grows to `22px` on hover/active)
- Panel padding: `28px 30px`
- Panel header bottom: padding + margin `1.25rem` each
- Skill-group header: margin-top `1.75rem`, margin-bottom `0.75rem` (first one: top `0`)
- Card padding: `18px`
- Card gap (column): `10px`
- Primary grid gap: `14px`
- Chip pill padding: `0.35em 0.8em`
- Chip gap (between pills): `0.4rem`

### Border radius

- Cards & panel: **`0`** (sharp corners — system-wide rule)
- Chip pills: `999px`

### Borders

- Rail rows: `1px solid var(--color-border)` top + bottom on last
- Rail left edge: `3px` (the `::before` accent)
- Panel: hairline below header (`1px solid var(--color-border)`); no top accent
- Skill card: `1px solid color-mix(in srgb, var(--chip-c) 35%, transparent)`
- Chip pill: `1px solid color-mix(in srgb, var(--chip-c) 35%, transparent)`

### Shadows

None. This page has zero drop shadows. (The site's "shadows" tokens exist for floating chrome only.)

## Assets

- **Devicons** (existing CDN load): `devicon-rails-plain`, `devicon-ruby-plain`, `devicon-postgresql-plain`, `devicon-docker-plain`, `devicon-go-plain`, `devicon-nodejs-plain`, `devicon-typescript-plain`, `devicon-javascript-plain`, `devicon-vuejs-plain`, `devicon-kubernetes-plain`, `devicon-github-plain`, `devicon-amazonwebservices-plain-wordmark`, `devicon-terraform-plain`, `devicon-ansible-plain`, `devicon-swift-plain`, `devicon-stripe-plain`.
- **Font Awesome 6.5.0** (existing): the rail no longer renders the per-experience category icon (`fa-server`, `fa-layer-group`, `fa-gears`, `fa-cloud`, `fa-cubes`, `fa-apple`). Removing it is intentional — the rank number takes that slot. Keep the category icon attribute in the model in case it's needed elsewhere; just don't render it in the rail.
- **Body backdrop / fonts / navbar / footer** — no changes; the page inherits all of those from the existing application layout.

## Copy

Strings to add / update in `config/locales/{en,nl,de}.yml` under `pages.experience`:

- `pages.experience.title` — `"Experience"` (already exists)
- `pages.experience.subtitle` — `"What I've been doing"` (already exists)
- `pages.experience.years_of_experience_html` — `"<strong>%{years} years of experience</strong> — %{description}"` (or build it in the view)
- `pages.experience.skills_primary` — `"Top %{count} · primary"`
- `pages.experience.skills_secondary` — `"Also used"`

(Translate the new keys for `nl` and `de`. Voice: dry, sentence-case.)

## i18n notes

- The existing keys `pages.experience.skills_header` and `pages.experience.skills_total` (the "ordered by proficiency" + "N total" pair) are unused in the redesign. Either remove them or leave them — your call.
- The mono headers should remain uppercase via CSS (`text-transform: uppercase`), so the i18n strings can stay sentence-case.

## Files in this handoff

```
design_handoff_experience_page/
├── README.md                              ← this file
├── design_reference/                      ← the new design (HTML/JSX prototype)
│   ├── Experience.jsx                     ← the component (React, ~130 lines)
│   ├── data.js                            ← sample skills + experiences (shape mirrors CONTENT_DATA.yml)
│   ├── experience.css                     ← the extracted page-specific CSS
│   └── colors_and_type.css                ← design tokens (read-only reference; identical to _tokens.scss)
└── current_rails_source/                  ← what's currently in the Rails app — replace these
    ├── show.html.erb                      ← app/views/experience/show.html.erb
    ├── _experience.scss                   ← app/assets/stylesheets/_experience.scss
    └── experience_controller.js           ← app/javascript/controllers/experience_controller.js
```

## How to verify

1. Open `design_reference/Experience.jsx` + `experience.css` side by side with `current_rails_source/show.html.erb` + `_experience.scss`. Diff them in your head — the README's "What changes" table is the canonical list.
2. Run the new ERB against `CONTENT_DATA.yml`. The first panel (Full-Stack Development, 10 years, legendary) should match the layout sketch above with `01` in the rail.
3. Hover and click each rail row. Year-bar should brighten, left-edge strip should scale in, panel content should swap.
4. Resize to <900px wide — rail should stack above panel. Resize to <720px — primary cards should stack.
5. Toggle the theme. The translucent backgrounds and `color-mix` chip tints should adapt to the light theme automatically (they're all RGBA / color-mix against tokens, not hard-coded greys).
