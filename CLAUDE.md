# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A personal portfolio/CV website built with Rails 8.1.3. It's a public-facing site (no authentication) with planned pages for home, experience, career, projects, contact, and CV download. See `PROJECT_OVERVIEW.md` for the full spec.

## Commands

```bash
bin/setup          # Install dependencies, create and prepare databases
bin/dev            # Start development server
bin/rails test     # Run all tests
bin/rails test test/models/user_test.rb  # Run a single test file
bin/rubocop        # Style linting
bin/brakeman --quiet --no-pager  # Security scan
bin/ci             # Full pipeline: setup → style → security → tests
```

## Architecture

**Stack:** Rails 8.1.3 · Ruby 3.4.7 · Hotwire (Turbo + Stimulus) · Importmap · Propshaft · Custom CSS

No Node.js build step — JavaScript is managed via importmap (`config/importmap.rb`). Assets go through Propshaft.

**Deployment:** Docker → Kamal. The `bin/ci` script mirrors what GitHub Actions runs on push.

## Key Conventions

- Ruby style follows `rubocop-rails-omakase` (inherited in `.rubocop.yml`)
- Stimulus controllers live in `app/javascript/controllers/`
- CSS lives in `app/assets/stylesheets/` via manifest

### CSS Architecture

Custom design system — no framework dependency.

**File responsibilities:**

| File | Purpose |
|---|---|
| `_tokens.scss` | CSS custom properties: colours, fonts, spacing, breakpoints |
| `_variables.scss` | SCSS compile-time variables (breakpoints: `$bp-sm/md/lg/xl`) |
| `_base.scss` | Reset, body, `a`, `img`, global keyframes |
| `_layout.scss` | `.container`, `.section`, flex/spacing utilities |
| `_typography.scss` | Heading scale, text/font/colour utility classes |
| `_components.scss` | Shared UI: buttons, tags, forms, tooltip, badge, status banner, image placeholder |
| `_skills.scss` | Skill display components: `.sk-*`, `.exp-skills-header`, `.lang-card*` |
| `_navbar.scss` | Navbar only |
| `_footer.scss` | Footer only |
| `_home.scss` | Home page only |
| `_experience.scss` | Experience page tab interface only |
| `_career.scss` | Career/timeline components only |
| `_projects.scss` | Projects page only |
| `_contact.scss` | Contact page only |
| `_cv.scss` | CV page only |
| `_cv_download.scss` | CV download page only |

**Naming — semantic prefix approach:**
- Component prefixes: `.tl-*` (timeline), `.sk-*` (skills), `.proj-*` (projects), `.exp-*` (experience), `.cv-*` (CV), `.navbar-*`, `.home-*`
- State classes: always `.is-*` prefix — `.is-active`, `.is-open`, `.is-scrolled`
- Utility classes: `.mb-*`, `.mt-*`, `.text-*`, `.font-*`, `.has-*`, `.is-flex`

**Token discipline:**
- All colours must use CSS custom properties from `_tokens.scss` — no hardcoded hex values in component or page files
- Alpha variants: use `color-mix(in srgb, var(--token) X%, transparent)` — not `rgba()` with raw values
- Inline CSS variables on HTML elements (`style="--chip-c: ..."`) are the correct pattern for per-element dynamic values (e.g. brand colours from the database)

**Tooltips:** use `data-tip` attribute only — styles live in `_components.scss` as `[data-tip]`

**Breakpoints** (defined in `_variables.scss`, use via `@use "variables" as *`):
```
$bp-sm:  640px   $bp-md:  768px   $bp-lg: 1024px   $bp-xl: 1280px
```

**Accessibility baseline:** WCAG 2.1 AA. Interactive components need correct ARIA roles. Decorative elements need `aria-hidden="true"`. Icon-only buttons need `aria-label`.

### Assets

Logo SVGs live in `app/assets/images/logo/`. Use `image_tag "logo/filename.svg"` in templates. Light/dark variants are switched via CSS on `[data-theme="light"]`. The favicon is at `public/icon.svg`.

## Content

### Audience
Both recruiters screening for permanent roles and freelance clients looking to hire directly.
Preference is toward permanent employment, but open to both. No specific industry focus.

### Tone
Personal and human rather than corporate. Informal but competent — the kind of person you'd
want to work with, not just hire. Occasional dry humour is fine; never forced.
Icon library: Devicons (tech stack) + Font Awesome (categories/UI).
(Further tone refinement TBD — revisit once first page copy is drafted.)