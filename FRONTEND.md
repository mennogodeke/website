# Frontend Review & Refactor Plan

This document covers the full HTML/CSS audit of the project. Each section has a status and notes.
Add your comments/decisions inline — prefix them with `> YOUR NOTE:` so they're easy to spot.

---

## Agreed Conventions

### CSS Naming
BEM-adjacent semantic prefix approach (codify existing, don't rename):
- Component prefixes: `.tl-*` (timeline), `.sk-*` (skills), `.proj-*` (projects), `.exp-*` (experience), `.cv-*` (CV), `.navbar-*`, `.home-*`
- State classes: always `.is-*` prefix (`.is-active`, `.is-open`, `.is-scrolled`) — currently `.open` in `_job.html.erb` violates this
- Utility classes: `.mb-*`, `.mt-*`, `.text-*`, `.font-*`, `.has-*`, `.is-flex`
- No framework dependency — custom tokens + components only
- These conventions will be documented in `CLAUDE.md` once agreed

> YOUR NOTE:

### Breakpoints
Standardise to a 4-step scale defined in `_tokens.scss`:
```
$bp-sm:  640px   // mobile → phablet
$bp-md:  768px   // phablet → tablet
$bp-lg: 1024px   // tablet → desktop
$bp-xl: 1280px   // desktop → wide
```
Currently: each page file picks its own number (640, 700, 720, 900, 1023px all appear).

> YOUR NOTE:

### Token discipline
- All colours through `_tokens.scss` custom properties — no hardcoded hex values in component/page files
- Inline CSS variables set on HTML elements (`--chip-c`, `--entry-accent`, `--row-color`) must be documented with a comment in the relevant CSS file

> YOUR NOTE:

### Accessibility baseline
- WCAG 2.1 AA
- All interactive components must have correct ARIA roles
- Decorative elements: `aria-hidden="true"`
- Icon-only buttons: `aria-label`

> YOUR NOTE:

---

## Phase 1 — View Logic & Partials

These are Rails-specific improvements: logic that belongs in helpers or should be extracted to partials.

### 1.1 Floating chip field → helper + partial
**File:** `app/views/pages/home.html.erb:3–19`

The `chip_positions` array (20 hardcoded coordinate pairs) is defined inline in the view, then used in a loop to render chip spans. Two problems:
1. Data/logic in the view — positions belong in a helper or constant
2. The entire chip field should be a partial so it can be reused or tested independently

**Proposed:**
- `app/helpers/home_helper.rb` → `chip_positions` method returning the array
- `app/views/pages/_chip_field.html.erb` → the chip field markup
- Called as `<%= render "chip_field", skills: @chip_skills %>`

> YOUR NOTEo: lets also remove the right section of the home hero completely for now

### 1.2 Company initials → helper method
**Files:** `app/views/pages/home.html.erb:111`, `app/views/jobs/_job.html.erb:1`

```ruby
initials = job.company.split.map { |w| w[0] }.join.upcase.first(2)
```
Duplicated in two templates. Also brittle (hyphenated names, single-word companies).

**Proposed:** `app/helpers/application_helper.rb` → `company_initials(name)` method

> YOUR NOTE: Lets use only the first letter of the company for now

### 1.3 Skill chip colour → model method
**Files:** `app/views/experience/show.html.erb:52,67`, `app/views/jobs/_job.html.erb:25`, `app/views/pages/home.html.erb:92`

```ruby
skill.accent.present? ? skill.accent : "var(--color-text-faint)"
```
Repeated in at least 4 places across 3 files.

**Proposed:** `app/models/skill.rb` → `def chip_color = accent.presence || "var(--color-text-faint)"`
Then used as `skill.chip_color` everywhere.

> YOUR NOTE: Can't we just use skill.accent, and have skill.accent default to --color-text-faint if not set?

### 1.4 Skill card → shared partial
**Files:** `app/views/experience/show.html.erb:51–57`, `app/views/pages/home.html.erb:91–99`

The `.sk-card` structure is identical in both places:
```erb
<div class="sk-card" style="--chip-c: <%= skill.chip_color %>">
  <i class="<%= skill.icon %> icon"></i>
  <span class="name"><%= skill.name %></span>
  <p class="desc"><%= skill.description.strip %></p>
</div>
```

**Proposed:** `app/views/skills/_skill_card.html.erb`
Called as `<%= render partial: "skills/skill_card", collection: primary, as: :skill %>`

> YOUR NOTE: Sounds good

### 1.5 Timeline rail → partial
**Files:** `app/views/pages/home.html.erb:122–127`, `app/views/jobs/_job.html.erb:36–40`

```erb
<div class="tl-rail" aria-hidden="true">
  <span class="yr"><%= job.end_date ? job.end_date.year : "NOW" %></span>
  <div class="tl-rail-dot"></div>
  <span class="yr"><%= job.start_date.year %></span>
</div>
```
Identical in both. The "NOW" string is also a candidate for i18n.

**Proposed:** `app/views/jobs/_timeline_rail.html.erb`

> YOUR NOTE: lets keep it as is for now

### 1.6 Experience panel inline gradient → CSS
**File:** `app/views/experience/show.html.erb:35`

```erb
style="--panel-color: var(--color-primary); --panel-grad: linear-gradient(160deg, var(--color-h1-bg-from) 0%, var(--color-h1-bg-mid) 50%, var(--color-h1-bg-to) 100%)"
```
This is a static value — it doesn't change per-record. It belongs in `_experience.scss`, not inline on the element.

> YOUR NOTE: agreed

### 1.7 `.open` → `.is-open` state class
**File:** `app/views/jobs/_job.html.erb:2`

```erb
<div class="tl-entry<%= " open" if first %>
```
Violates the agreed `.is-*` state class convention. Needs to change in the template, the CSS, and the Stimulus controller.

> YOUR NOTE: can this logic be moved to helper as well instead of having the logic directly in the html view?

---

## Phase 2 — HTML Issues

### 2.1 Duplicate career status banner
**Files:** `app/views/layouts/application.html.erb:33–49`, `app/views/pages/home.html.erb:55–70`

The banner renders twice on the home page. The layout version wraps it in `unless current_page?(root_path)` — the intent was clearly to show it everywhere *except* home, then have the home page render its own version. But it ends up rendering twice.

**Fix options:**
- A) Keep it in the layout only (remove the `unless` guard, let it show on home too) — simplest
- B) Keep it in home only, remove from layout — but then other pages lose it
- C) Extract to a partial, render conditionally in both places with different styles for home

> YOUR NOTE: Lets go with C

### 2.2 Typography preview markup
**File:** `app/views/pages/home.html.erb:73–81`

Dev/design placeholder — h1 through h6 with "This is an H1" text. Should be removed before launch.

> YOUR NOTE:

### 2.3 `.upcase` in template → CSS
**File:** `app/views/cv_downloads/new.html.erb`

```erb
t("cv_download.send").upcase
```
Text transforms belong in CSS (`text-transform: uppercase`), not templates. Screen readers may spell out each letter if text is uppercase in the DOM.

> YOUR NOTE: I agree it should be in CSS, however, the btn class is using the font-family: --font-display. This --font-display is actually using a all caps font. Whats the best approach here? 

### 2.4 Tooltip attribute inconsistency
**Files:** `app/views/experience/show.html.erb:68` uses `data-tooltip`, everywhere else uses `data-tip`

One needs to change to match the other. CSS in `_components.scss` only handles `[data-tip]`, so `data-tooltip` in experience is currently unstyled.

> YOUR NOTE: Go with what you think is best

---

## Phase 3 — CSS Issues

### 3.1 Hardcoded hex colours (4 locations)
Colours that bypass `_tokens.scss`:

| File | Value | Should be |
|---|---|---|
| `_components.scss` (tooltips) | `#0d1117`, `#30363d`, `#e6edf3` | `var(--color-tooltip-bg)` etc. |
| `_experience.scss` (tooltips) | `#0d1117`, `#e6edf3` | Same tokens |
| `_home.scss` (badge dot) | `#4ade80` | `var(--color-accent)` |
| `_footer.scss` (Claude icon) | `#cc785c` | New token e.g. `--color-icon-claude` |

> YOUR NOTE: I think we should also rename the home-baddge class to something like looking-for-work-badge

### 3.2 Tooltip duplication
`[data-tip]` in `_components.scss` and `[data-tooltip]` in `_experience.scss` are near-identical blocks with hardcoded colours. Should be one component using one attribute name.

> YOUR NOTE: Yes sounds good

### 3.3 Breakpoint alignment
Once the standard scale is agreed (Phase 1 of conventions), all media queries need updating. Current numbers to migrate:
- 480px → `$bp-sm` (640px) or remove
- 640px → `$bp-sm` ✓
- 700px → `$bp-md` (768px) closest
- 720px → `$bp-md` ✓
- 900px → review (falls between `$bp-md` and `$bp-lg`)
- 1023px → `$bp-lg` (1024px) ✓

> YOUR NOTE: Yes but lets wait with this untill we are done with all the other steps if possible

### 3.4 Misplaced styles
`.lang-card*` styles are in `_base.scss` but only used on the home page. Should move to `_components.scss` or `_home.scss`.

> YOUR NOTE: lets move it to _components.scss

### 3.5 Empty `_variables.scss`
Currently 5 blank lines. Either delete it or document its purpose (override point for per-environment theming, etc.).

> YOUR NOTE: I believe this was meant as override point. Howver all variable related logic seems to be in _tokens.scss. Lets use _variables.scss instead

---

## Phase 4 — Accessibility

### 4.1 Experience tab interface incomplete ARIA
**File:** `app/views/experience/show.html.erb`

Rail buttons have `role="tab"` and `aria-selected` ✓, but panels are missing:
- `role="tabpanel"` on each panel div
- `aria-labelledby` linking each panel to its tab button
- Stable `id` attributes on both tabs and panels

> YOUR NOTE: lets revisit this later when we are done with the other topics

### 4.2 Decorative floating chips
**File:** `app/views/pages/home.html.erb:15`

Chip `<span>` elements are purely decorative but have no `aria-hidden="true"`. Screen readers will announce the icon class names.

> YOUR NOTE: This can be fixed by adding aria-hidden=true? If yes, please go ahead

### 4.3 Social icon links missing labels
**File:** `app/views/pages/contact.html.erb`

Icon-only links with no `aria-label`. A screen reader will announce nothing meaningful.

> YOUR NOTE: Ok you can use https://github.com/mennogodeke for github, https://www.linkedin.com/in/menno-godeke-b5b09b10a/ for linkedin, info@menno.codes for email, and keep discord and slack empty for now, i will add those later but i first have to create the accounts for that. BTW, can you create a gh issue to create those accounts so its not forgotten.

---

## Phase 5 — Bulma in CV Layout

**File:** `app/views/layouts/cv.html.erb`

Loads `bulma.min` CSS despite the project's no-framework policy. Also loads both Bulma and the app stylesheet, suggesting an incomplete migration.

Action: remove Bulma, verify CV renders correctly with app stylesheets only.

> YOUR NOTE:

---

## Phase 6 — Review Subagent

Create `.claude/commands/review-html-css.md` — a slash command that reviews HTML/ERB templates and SCSS files against this project's conventions. It should:
- Report violations by category (token discipline, naming, breakpoints, ARIA, semantic HTML)
- Not auto-fix — report only, with file:line references
- Reference CLAUDE.md as the source of truth for conventions

> YOUR NOTE: Looks good, but lets also add a design/front-end section either in CLAUDE.md or README.md summarizing the html/css guidelines and current styling of the website. Lets also have the skill/agent make sure this section always accurately describes the state of the wesbsites design

---

## Out of Scope (GitHub Issues to create separately)

These need real content or backend work — not part of the structural refactor:

- [ ] Contact form `url: "#"` — needs a controller action and mailer
- [ ] Social links `href="#"` — need real URLs (LinkedIn, Discord, Slack)
- [ ] Image stubs throughout — need real assets
- [ ] Company initials edge cases (handled by helper in Phase 1, but data quality is separate)
- [ ] CV languages hardcoded — should query database

> YOUR NOTE:
