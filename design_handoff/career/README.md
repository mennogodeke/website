# Handoff: Career page redesign

## Overview

This is a redesigned `/jobs` (a.k.a. "Career") page for **menno.codes**. The current page is a left-rail timeline with chronological job entries that expand to show skills. The redesign keeps the timeline concept but:

- **Lifts the "Open to work" status row out of the navbar / hero context into a thin always-visible banner** above the timeline, with primary CTAs (`Get My CV →`, `Get In Touch`).
- **Moves the timeline rail to the right** instead of the left, with start year ‣ accent dot ‣ end year stacked vertically inside it.
- Drops the inline date string in favour of those two year stamps in the rail.
- Shifts the rarity accent strip from the left edge of the entry to the right edge of the content column (still scales-in on open).

The page lists work history in reverse chronological order (most recent first). Each entry is a clickable accordion that reveals the role description and the full skill set used. The visual story is "experience compounding upward" — the topmost entry gets the highest rarity tier (legendary), descending through epic → rare → uncommon → common as you scroll down.

## About the design files

The files in `design_reference/` are **design references built in HTML/JSX** — they show the intended look and behavior of the redesigned page. They are **not production code to copy verbatim**.

Your task is to **recreate this design inside the existing Rails 8 codebase** (`website/`), using its established patterns:

- Server-rendered ERB templates (`app/views/jobs/index.html.erb`, `app/views/jobs/_job.html.erb`)
- SCSS partials in `app/assets/stylesheets/` compiled via `dartsass-rails`
- Stimulus controllers in `app/javascript/controllers/` for accordion state
- Design tokens already declared in `app/assets/stylesheets/_tokens.scss`

`current_rails_source/` contains the **existing** Rails files for this page so you can see what's being replaced.

## Fidelity

**High-fidelity.** Exact colors, typography, spacing, and component structure are documented below.

## What changes from the current page

| Aspect | Current (`current_rails_source/`) | Redesign (`design_reference/`) |
| --- | --- | --- |
| Status / CTA banner | Lives in the home hero only | **New: lifted into a dedicated banner above the timeline.** "Open to work" pill + 2-sentence copy + `Get My CV →` + `Get In Touch` |
| Timeline rail position | **Left** — vertical line at `left: 19px` with a `.tl-dot` on each entry | **Right** — vertical line at `right: calc(--tl-rail-center - 1px)` with a `.tl-rail` column on each entry |
| Rail width | n/a (rail is 2px line + dot) | `--tl-rail-w: 140px` (collapses to `96px` below 700px) |
| Rail content | A single dot on the centred vertical line | A vertical stack: `start year` ‣ `accent dot` ‣ `end year` (or `NOW`) |
| Per-entry layout | `padding-left: 56px` (content shifted right of the rail) | `padding-right: var(--tl-rail-w)` (content shifted left of the rail) |
| Rarity accent strip | 3px on the **left** edge, `scaleX(0) → scaleX(1)` on open | 3px on the **right** edge of the content column (just left of the rail), `scaleY(0) → scaleY(1)` on open |
| Entry dot in closed state | `var(--color-bg)` with rarity border | Same (12px hollow circle, rarity-bordered) |
| Entry dot in open state | Filled with rarity color | Filled with rarity color + glow (`box-shadow` not currently set — fine to leave) |
| Date display | Inline `tl-meta` string: `MAY 2017 · NOW` under the title | Removed; replaced by the two year stamps in the rail |
| Company logo / monogram | 38px square on the **left** of the title (with hairline border) | 48px square on the **left** of the title; hairline border, monospace 2-letter monogram. **Border color animates to rarity accent on hover/open.** |
| Role line | `Title @ Company` on one line with `.tl-company` faded suffix | `Title` on the paint-stroke + separate `@ Company` label faded next to it (`.tl-at-company`) |
| Duration | Date string only | Year stamps in the rail tell the story; specific duration chip is no longer rendered (the JSX has a stub but isn't wired) |
| Highlight class assignment | `highlights[i % length]` — cycles `legendary → epic → rare → uncommon → common` | Same (`RARITY_ORDER[index % RARITY_ORDER.length]`) — kept |
| Paint-stroke on title | `.highlight-{tier}` background gradient on the title `<span>`, dimmed when closed for everything except legendary | Same. Closed-state stroke is hidden via `.tl-entry:not(.open):not(.tl-entry--uncommon) .tl-role span { background: none; padding: 0; color: inherit; }` — note: the rule's specific class list (`tl-entry--uncommon`) is a quirk left over from earlier work; **simplify to "hide all non-open strokes"** in the rewrite if you want |
| Open entry background | `color-mix(in srgb, var({tier}) 5%, var(--color-bg-card))` per-rarity (via the `@mixin tl-rarity`) | Single `var(--color-bg-card)` — no per-rarity tint. The accent strip on the right + the dot fill carry the rarity now. Drop the mixin or keep it; the redesign doesn't depend on it. |
| Closed-state inline skills | Not shown | The JSX has a `.tl-primary-skills` block (CSS exists, JSX commented out). **Not part of v2** — kept as a future enhancement. Skip this for now. |
| Skill tags inside body | `.skill-tag` with `--chip-c` per skill + `data-tip` tooltip | Same. The `SkillTag` component in `Components.jsx` is the design-system canonical form. |

## Screens / Views

There is **one screen**: `/jobs` (route: `jobs#index`).

### Layout

```
┌─────────────────────────────────────────────────────────────────────────┐
│ H1  "Career"                                  (yellow paint-stroke)     │
│ H2  "Where I've worked"                                                 │
│                                                                         │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │ [● Open to work]  Permanent senior engineering…   [Get My CV →]   │  │
│  │                   Based in Germany…               [Get In Touch]  │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│                                                                         │
│  ┌────────────────────────────────────────────────────┬─2022──────────┐│
│  │ [KT]  SENIOR SOFTWARE ENGINEER  @ Kape Technologies│      ●        ││
│  │                                                ▼  │   2026/NOW    ││
│  ├────────────────────────────────────────────────────┼─2019──────────┤│
│  │ [KT]  SOFTWARE ENGINEER  @ Kape Technologies       │      ○        ││
│  │                                                ▼  │   2022        ││
│  ├────────────────────────────────────────────────────┼─2017──────────┤│
│  │ [ZG]  JUNIOR SOFTWARE ENGINEER  @ ZenGuard         │      ○        ││
│  │                                                ▼  │   2019        ││
│  ├────────────────────────────────────────────────────┼─2017──────────┤│
│  │ [ZG]  SOFTWARE ENGINEERING INTERN  @ ZenGuard      │      ○        ││
│  │                                                ▼  │   2017        ││
│  ├────────────────────────────────────────────────────┼─2016──────────┤│
│  │ [SB]  SOFTWARE ENGINEERING INTERN  @ Shopboostr    │      ○        ││
│  │                                                ▼  │   2016        ││
│  └────────────────────────────────────────────────────┴───────────────┘│
└─────────────────────────────────────────────────────────────────────────┘
```

### Outer container

- `<section class="section container">` — same shell as the rest of the site (4rem block padding, 1280px max-width, 1.5rem gutter).
- `h1.page-h1` — yellow paint-stroke heading.
- `h2` — Anton SC subtitle.

### Status banner (`.career-status`)

A thin always-visible banner immediately above the timeline.

- Layout: `display: flex; align-items: center; justify-content: space-between; gap: 1.5rem; flex-wrap: wrap;`
- Padding: `1rem 1.25rem`
- Background: `rgba(255,255,255,0.02)`, border `1px solid var(--color-border)`
- Margin-bottom: `1.25rem`

Left side (`.career-status-main`):
- `display: flex; align-items: center; gap: 1rem; flex-wrap: wrap;`
- **"Open to work" pill** — re-use `.home-badge` from the home page. Pill (border-radius 999px) with a blinking green dot (`badge-blink` keyframe), Anton uppercase label.
- **Status copy** (`.career-status-copy`): DM Sans `0.85rem`, color `--color-text-muted`, line-height `1.5`, `max-width: 540px`.
- The `<strong>` inside it: color `--color-text`, weight `600`.
- Copy: `"Permanent senior engineering, back-end focused or full-stack."` followed by `" Based in Germany, open to remote and hybrid. Good problems and good people are enough."`

Right side (`.career-status-actions`):
- `display: flex; gap: 0.5rem;`
- Two `<Button size="sm">` instances using the existing button system:
  - `variant="primary"` — `Get My CV →`
  - default (ghost/secondary) — `Get In Touch`

### Timeline track (`.tl-track`)

- `position: relative;`
- The continuous vertical line runs through the **centre of the right-side rail column**: `.tl-track::before` is `position: absolute; right: calc(var(--tl-rail-center) - 1px); top: 0; bottom: 0; width: 2px; background: var(--color-border-2);`
- Rail width is configurable via `:root { --tl-rail-w: 140px; --tl-rail-center: 70px; }` (half of width). At `max-width: 700px`, override to `96px` / `48px`.

### Entry (`.tl-entry`)

One per job. Rendered in reverse-chronological order (most recent first). The Nth entry (0-indexed) gets `RARITY_ORDER[N % 5]` as its rarity:
- `0` → legendary
- `1` → epic
- `2` → rare
- `3` → uncommon
- `4` → common
- `5` → legendary again, etc.

Inline CSS custom property: `style="--entry-accent: var(--color-{rarity});"`.

- `position: relative; padding-right: var(--tl-rail-w); border-top: 1px solid var(--color-border);`
- Last entry adds a `border-bottom`.
- `transition: background 0.15s;`
- Open state: `background: var(--color-bg-card);`
- Accent strip (`.tl-entry::after`): the 3px vertical bar at `right: var(--tl-rail-w)` (right edge of content, just left of the rail), painted in `var(--entry-accent)`. `transform: scaleY(0) → scaleY(1)` on `.open`, origin `top`, duration `0.2s ease`.

### Entry header (`.tl-header`)

The always-visible row. Click toggles `.open` on the entry.

- `display: flex; align-items: center; gap: 1rem; padding: 1.5rem 1.5rem 1.5rem 0;`
- `cursor: pointer; user-select: none;`
- Three children:

1. **Company monogram** (`.tl-company-logo`):
   - 48 × 48, hairline border, `var(--color-bg-card)` background, Anton 700, `0.95rem`, uppercase, centred. Shows the company's initials (e.g. `KT`, `ZG`, `SB`).
   - Border + text color animate to `var(--entry-accent)` on hover/open.
   - At `max-width: 700px`, shrinks to 40×40 with `0.7rem` text.
2. **Header main** (`.tl-header-main`) — `flex: 1; min-width: 0;` Contains the role row:
   - `.tl-role-row { display: flex; align-items: flex-start; gap: 0.625rem; flex-wrap: wrap; min-width: 0; }`
   - `.tl-role` — Anton, `clamp(1.25rem, 2.2vw, 1.75rem)`, line-height `0.9`, uppercase, letter-spacing `-0.01em`. Contains a single `<span>` set via the `Highlight` helper (i.e. a `.highlight-{tier}` gradient paint-stroke). When the entry is **closed**, the stroke is suppressed and the title shows in plain text.
   - `.tl-at-company` — DM Sans, `0.65rem` clamp-base (~1rem effective), font-size `1rem`, font-weight `400`, color `--color-text-faint`. Sits next to the role title on the same line. Color → `--color-text-muted` on hover/open.
3. **Chevron** (`.tl-chevron`):
   - 26 × 26, centred icon (`fa-solid fa-chevron-down`), `0.625rem` icon size, color `--color-text-faint`.
   - On `.open`, rotates 180° (`transform: rotate(180deg)`), color → `--color-text-muted`. Transition `0.28s ease` on transform, `0.15s` on color.

### Entry rail (`.tl-rail`)

The right-side column with the year stamps and the dot.

- `position: absolute; right: 0; top: 0; bottom: 0; width: var(--tl-rail-w);`
- `display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 0.5rem;`
- `pointer-events: none;` (the header click target is the row; the rail is decorative)
- Three children, top-to-bottom:
  1. `.yr` (start year) — mono, `0.8rem`, tracking `0.06em`, color `--color-text-faint`
  2. `.tl-rail-dot` — 12 × 12 hollow circle, 2px border `var(--color-border-2)`, `border-radius: 50%`, background `var(--color-bg)`. On hover: border becomes `--entry-accent`. On open: filled with `--entry-accent`, border also `--entry-accent`, plus a soft `box-shadow: 0 0 0 6px color-mix(in srgb, var(--entry-accent) 18%, transparent)` if you want a halo (not currently in the CSS — optional).
  3. `.yr` (end year) — same style as start year. **If `end === 2026`** (the data's sentinel for "still active"), render the string `NOW` instead.

Hover or open the entry → both `.yr` colors brighten to `--color-text-muted`.

### Entry body (`.tl-body`)

The expandable content using the CSS `grid-template-rows: 0fr → 1fr` trick (no JS height calculations, no `max-height` hack).

- `.tl-body { display: grid; grid-template-rows: 0fr; transition: grid-template-rows 0.32s ease; }`
- `.tl-entry.open .tl-body { grid-template-rows: 1fr; }`
- `.tl-body-inner { overflow: hidden; }`
- `.tl-body-content { padding: 0 1.5rem 1.5rem 0; }`

Inside the body:

- `.tl-desc` — `0.875rem`, line-height `1.75`, color `--color-text-muted`, margin `0 0 1rem`. Paragraph of role description.
- `.tl-skills` — `display: flex; flex-wrap: wrap; gap: 0.375rem;`. One `.skill-tag` per skill (use the existing `.skill-tag` component from `_components.scss`, with `--chip-c` set per skill and `data-tip` carrying the description for the tooltip).

## Interactions & Behavior

### Accordion

- **One open at a time.** Clicking an entry's header opens it and closes any other open entry.
- The existing two-controller Stimulus pattern (`career` on the track + `career-entry` on each entry, with the `career-entry:opened` event bubbling) is solid — keep it. No structural changes needed.
- On initial page render: the topmost entry (most recent job) starts open. Add `class="open"` to the first `.tl-entry` server-side, and set its corresponding rail dot to filled.
- Toggling re-renders nothing — pure CSS class flip + the grid-rows transition handles the reveal.

### Hover

- Entry: no entry-level hover background.
- Rail dot border: `--color-border-2 → --entry-accent` over `0.2s`.
- Year stamps: `--color-text-faint → --color-text-muted` over `0.2s`.
- Company monogram border: `--color-border → --entry-accent` over `0.2s`.
- "@ Company" label: `--color-text-faint → --color-text-muted` over `0.2s`.

### Click anywhere in the header

The entire `.tl-header` is the click target (`cursor: pointer; user-select: none;`). The chevron rotates `180°` on open. No keyboard interaction is built-in in the current implementation — consider making `.tl-header` a `<button>` or adding `tabindex="0"` + `role="button"` + Enter/Space handling for a11y.

### Responsive

`@media (max-width: 700px)`:
- `--tl-rail-w: 96px; --tl-rail-center: 48px;` — shrink the rail.
- `.tl-rail .yr` → `0.7rem`.
- `.tl-company-logo` → 40×40, `0.7rem` text.

The status banner already wraps via `flex-wrap: wrap`; CTAs will drop below the copy on narrow screens.

## State Management

Two Stimulus controllers, both already in the codebase:

- **`career_controller.js`** — on the `.tl-track`. Listens for `career-entry:opened` events bubbling up, closes every entry that didn't fire the event. (Enforces "one open at a time.")
- **`career_entry_controller.js`** — on each `.tl-entry`. `toggle()` flips the `.open` class; if the entry was just opened, it dispatches `career-entry:opened` upward.

Keep both. The only change needed is: server-render `.open` on the first entry (most recent job) so it loads expanded.

## Design Tokens

All values come from the existing `app/assets/stylesheets/_tokens.scss`. The relevant ones for this page:

### Colors

| Token | Hex (dark) | Use |
| --- | --- | --- |
| `--color-primary` | `#f5e90c` | Buttons (Get My CV), focus ring |
| `--color-text` | `rgba(255,255,255,0.92)` | Body strong, monogram text on open/hover |
| `--color-text-muted` | `rgba(255,255,255,0.7)` | Description, hover-state year stamps |
| `--color-text-faint` | `rgba(255,255,255,0.55)` | Year stamps, chevron, "@ Company" |
| `--color-border` | `rgba(255,255,255,0.10)` | Entry top/bottom hairlines, banner border |
| `--color-border-2` | `rgba(255,255,255,0.16)` | Vertical timeline line, dot border (closed) |
| `--color-bg` | `#0b1729` | Hollow dot fill (closed) |
| `--color-bg-card` | `rgba(255,255,255,0.04)` | Monogram background, open-entry background |
| `--color-legendary` | `#FF8000` | First entry (most recent) |
| `--color-epic` | `#A335EE` | Second entry |
| `--color-rare` | `#0070DD` | Third entry |
| `--color-uncommon` | `#1EFF00` | Fourth entry |
| `--color-common` | `#9D9D9D` | Fifth entry |

Plus the matching `--highlight-{tier}-from/mid/to` gradient stops used by the `.highlight-{tier}` classes on the role title (already wired in `_typography.scss`).

### Typography

| Token | Family | Use |
| --- | --- | --- |
| `--font-display` | Anton | Role title, monogram, page h1/h2 |
| `--font-body` | DM Sans | Description, "@ Company" label, status banner copy |
| `--font-mono` | `ui-monospace, …` | Year stamps in the rail, meta labels |

Sizes specific to this page:

- Role title: `clamp(1.25rem, 2.2vw, 1.75rem)`, line-height `0.9`, letter-spacing `-0.01em`
- "@ Company": `1rem`, weight `400`, color `--color-text-faint`
- Monogram: Anton 700, `0.95rem`, tracking `0.04em`
- Year stamps: mono `0.8rem` (rail), `0.7rem` (mobile)
- Description: `0.875rem`, line-height `1.75`
- Banner copy: `0.85rem`, line-height `1.5`, max-width `540px`

### Spacing

- Status banner: padding `1rem 1.25rem`, margin-bottom `1.25rem`, gap `1.5rem`
- Banner CTA group gap: `0.5rem`
- Entry header padding: `1.5rem 1.5rem 1.5rem 0` (right padding only — the rail occupies the right side already via `padding-right` on the entry)
- Entry padding-right: `var(--tl-rail-w)` (`140px` desktop, `96px` mobile)
- Header gap (between monogram, main, chevron): `1rem`
- Role row gap: `0.625rem`
- Body content padding: `0 1.5rem 1.5rem 0`
- Skills gap: `0.375rem`

### Border radius

- Cards / banner / entries: **`0`** (sharp corners — system rule)
- Dot: `50%`
- Monogram square: `0` (sharp)
- Skill tags: inherits from `.skill-tag` (pill, `999px`)
- "Open to work" pill: `999px` (from `.home-badge`)

### Borders & accents

- Entry top/bottom: `1px solid var(--color-border)`
- Vertical track line: `2px var(--color-border-2)`
- Entry accent strip (right edge of content, on open): `3px var(--entry-accent)`
- Rail dot (closed): `2px var(--color-border-2)` border, hollow
- Rail dot (open): filled `var(--entry-accent)`, same-color border
- Monogram: `1px solid var(--color-border)` → `--entry-accent` on hover/open
- Status banner: `1px solid var(--color-border)`

### Shadows

None on this page. (Optional: a soft `box-shadow: 0 0 0 6px color-mix(in srgb, var(--entry-accent) 18%, transparent)` halo on the open-state rail dot if you want extra emphasis.)

### Animation

- Entry background fade: `0.15s` ease
- Entry accent strip reveal: `0.2s` ease (`scaleY`)
- Dot border / fill: `0.2s`
- Chevron rotate: `0.28s` ease (`transform: rotate(180deg)`)
- Accordion body: `0.32s` ease (`grid-template-rows: 0fr → 1fr`)
- "@ Company" / year stamp / monogram color fades: `0.2s`

## Assets

- **Font Awesome** (existing): `fa-solid fa-chevron-down` for the accordion chevron, `fa-solid fa-arrow-right` (or the literal `→`) for the CTA suffix.
- **Devicons** (existing): used inside `.skill-tag` chips, one per skill — already wired through `CONTENT_DATA.yml`.
- **Company logos** — not used in the redesign. Stick with the 2-letter monogram (the codebase already derives initials from `job.company.split.map { |w| w[0] }.join.upcase.first(2)` in `_job.html.erb`).
- **No new image assets needed.**

## Copy

The job records already carry `title`, `company`, `start_date`, `end_date`, and `description`. New strings to add under `pages.career` in `config/locales/{en,nl,de}.yml`:

- `pages.career.title` — `"Career"` (exists)
- `pages.career.subtitle` — `"Where I've worked"` (exists)
- `pages.career.status_label` — `"Open to work"`
- `pages.career.status_html` — `"<strong>Permanent senior engineering, back-end focused or full-stack.</strong> Based in Germany, open to remote and hybrid. Good problems and good people are enough."`
- `pages.career.cta_cv` — `"Get My CV →"`
- `pages.career.cta_contact` — `"Get In Touch"`
- `pages.career.now` — `"NOW"` (the sentinel rendered in the rail for currently-held roles)

Translate to `nl` and `de`. The status copy is short enough to translate freely; keep it dry and first-person.

## Date / "NOW" sentinel

The current Rails model has nullable `end_date` (rendered as `"Present"`). For the new design, the rail's end-year stamp:
- If `job.end_date.nil?` → render `t('pages.career.now')` (i.e. `NOW`).
- Otherwise render `job.end_date.year.to_s`.
- Start year is `job.start_date.year.to_s`.

The prototype uses an integer year (2017, 2026) for simplicity — in production, `.year` off the Date object is fine.

## Files in this handoff

```
career/
├── README.md                              ← this file
├── design_reference/                      ← the new design (HTML/JSX prototype)
│   ├── Career.jsx                         ← the component (React, ~120 lines)
│   ├── Components.jsx                     ← helpers it uses (Button, SkillTag, Highlight)
│   ├── data.js                            ← sample jobs + skills (shape mirrors CONTENT_DATA.yml)
│   ├── career.css                         ← extracted page-specific CSS
│   └── colors_and_type.css                ← design tokens (identical to _tokens.scss)
└── current_rails_source/                  ← what's currently in the Rails app — replace these
    ├── index.html.erb                     ← app/views/jobs/index.html.erb
    ├── _job.html.erb                      ← app/views/jobs/_job.html.erb
    ├── _career.scss                       ← app/assets/stylesheets/_career.scss
    ├── career_controller.js               ← app/javascript/controllers/career_controller.js
    └── career_entry_controller.js         ← app/javascript/controllers/career_entry_controller.js
```

## How to verify

1. Open `design_reference/Career.jsx` + `career.css` side by side with `current_rails_source/_job.html.erb` + `_career.scss`. The README's "What changes" table is the canonical diff.
2. Render `/jobs` against the production `CONTENT_DATA.yml`. The first entry (Senior Software Engineer @ Kape, 2022 → NOW) should be open by default with a `legendary` orange accent strip on the right and a filled orange dot in the rail.
3. Click each entry — chevron should rotate, body should expand smoothly (CSS grid-rows transition), the previously-open entry should close in the same gesture.
4. Resize to <700px — rail should shrink to 96px wide, monogram to 40×40, year stamps to 0.7rem. The banner CTAs should wrap below the copy.
5. Toggle theme. Translucent backgrounds and `color-mix` accents should adapt automatically.
