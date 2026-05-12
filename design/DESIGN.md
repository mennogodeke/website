# Design

## Overall look and feel

Bold, dark, typographically-driven. Inspired by Fortnite/Epic Games — high-contrast, uppercase display type, sharp edges, and a single electric accent colour on a deep navy background. The aesthetic sits between editorial brutalism and gaming UI: confident, a little aggressive, but still legible and professional.

The fixed background texture (dark navy-to-cyan diagonal halftone) creates depth and atmosphere across all pages without competing with content.

---

## Layout

Built on Bulma CSS 1.0.4 (vendored). Bulma's class system is used directly and overridden via CSS custom properties in `:root` — never forked.

- **Sections** use Bulma's `.section` with size modifiers (`.is-medium`, `.is-large`) for vertical rhythm
- **Page containers** use Bulma's `.container` with width modifiers (`.is-max-desktop`, `.is-max-widescreen`) — max-widths are per-page and subject to change
- **Navbar** is fixed, transparent, Bulma-structured with a Stimulus controller for mobile burger toggle
- **No sidebar** — all layouts are single-column or simple grids
- **Homepage** is the exception: full-viewport hero with a two-column grid (text left, circular avatar right), followed by a site-wide footer
- **Footer** sits at the bottom of every page (document flow, not fixed)

---

## Colors

| Token | Value | Usage |
|---|---|---|
| `--app-bg` | `#0b1729` | Page background, card backgrounds |
| `--app-accent` | `#f5e90c` | Primary CTA, subtitle badges, hover states, focus rings |
| `--app-text` | `#ffffff` | All body and heading text |
| `--app-text-muted` | `rgba(255,255,255,0.6)` | Secondary text, intro copy |
| `--app-border` | `rgba(255,255,255,0.1)` | Subtle dividers |
| `--app-green` | `#00e676` | Status indicator (pulsing dot) |

**Expertise card accent colours** (body background + top border):

| Area | Colour |
|---|---|
| Back-end | `#ff6200` (orange) |
| Cloud & DevOps | `#7d09d6` (purple) |
| iOS & macOS | `#0f5edb` (blue) |
| Front-end | `#12e012` (green) |

---

## Typography

Two fonts from Google Fonts, loaded via `<link>` in the layout:

| Role | Font | Weights |
|---|---|---|
| Display (`--app-font-display`) | Barlow Condensed | 600, 700, 800, 900 |
| Body (`--app-font-body`) | Barlow | 400, 500, 600, 700 |

Bulma's title size scale is overridden in `:root` with fluid `clamp()` values:

| Class | Size |
|---|---|
| `.title.is-1` | `clamp(4.5rem, 9vw, 7.5rem)` |
| `.title.is-2` | `clamp(2.5rem, 5vw, 4rem)` |
| `.title.is-3` | `clamp(1.75rem, 3vw, 2.5rem)` |
| `.title.is-4` | `clamp(1.25rem, 2vw, 1.75rem)` |
| `.title.is-5` | `clamp(1rem, 1.5vw, 1.25rem)` |
| `.title.is-6` | `0.9rem` |

All `.title` elements are forced uppercase, weight 900, Barlow Condensed, line-height 0.9, letter-spacing -0.01em.

`.subtitle` sizes follow the same is-1 → is-6 scale and render as a yellow badge (`#f5e90c` background, near-black text), Barlow Condensed 800, uppercase.

---

## Elements

### Navigation

Fixed, full-width, transparent. Blends into the background texture. On scroll the texture shows through — no solid background added on scroll.

- **Logo** (`MENNO.CODES`): Barlow Condensed 800, no hover effect
- **Nav links**: Barlow Condensed 700, muted white → full white on active. Yellow 2px underline via `::after` on hover and active. No background highlight.
- **CTA** (`GET MY CV`): Yellow border, yellow text, fills yellow on hover. Sits in the navbar-end.
- **Mobile**: Bulma burger + Stimulus `navbar_controller` toggle. Dark frosted-glass dropdown.

### Titles

Bulma's `.title` and `.subtitle` are globally overridden:

- **`.title`** — Barlow Condensed 900, uppercase, white, line-height 0.9
- **`.subtitle`** — Yellow badge (`#f5e90c` background, near-black text), Barlow Condensed 800, uppercase, inline-block with padding. Used as a section label, not a traditional subtitle.
- **`.title-row`** — Flex wrapper that places a `.title` and `.subtitle` side-by-side, baseline-aligned. Used on Career, Experience, and Projects page headers.

### Buttons

Bulma's `.button` is globally overridden: no border-radius (sharp edges), Barlow Condensed 800, uppercase, letter-spacing 0.12em.

- **`.button.is-primary`** — Yellow fill, dark text, 2px yellow border. Inverts to transparent on hover.
- **`.button.is-outlined`** — Transparent, white border at 25% opacity. Border and text turn yellow on hover.
- Bulma size modifiers (`.is-small`, `.is-medium`, `.is-large`) work as normal.

### Forms

Bulma's `.input`, `.textarea`, and `.label` are globally overridden:

- **Inputs / textareas** — White background, dark text (`#0b1729`), subtle border. Yellow 2px focus ring with 25% yellow glow.
- **Labels** — Barlow Condensed 700, uppercase, letter-spacing 0.08em, muted white.

### Footer

White background, sits at the bottom of every page in document flow (not fixed). 3rem tall.

- **Left** — "Built with:" label + Devicons for Ruby, Bulma, GitHub, Docker, and a Font Awesome robot icon for Claude. Icons are slightly dimmed and brighten on hover.
- **Right** — `MENNO.CODES` logo (Barlow Condensed 800) and `© year Menno Godeke` copyright.

---

## Components/Resources

### Job

Used on the Career page. Full-bleed row list (`.career-list` + `.job-box`). Each row has a transparent background with a subtle top border. On hover: a 3px yellow left border appears and the row shifts right via `padding-left` transition, text brightens to full white.

Structure: job title + company name left, date range right.

### Expertise

Used on the Experience page in a **3-column grid** (`.expertise-grid.is-top`), responsive to 2-col at ≤1024px and 1-col at ≤640px.

Each card has:
- A 4px top border in the area's accent colour
- A 16:9 placeholder image (white background)
- A card body with a **semi-transparent area-colour background** (gradient with a white diagonal sheen); on hover the body transitions to a fully opaque glossy gradient
- Card header inside the body: area name (left) + years of experience as a large yellow number (right)
- Description text and skill tags below

Hover animations (all triggered together):
- **Lift** — `translateY(-6px)` with a deeper drop shadow
- **Image zoom** — image scales to 107%, cropped by the overflow-hidden wrap
- **Shimmer sweep** — a skewed white band sweeps left-to-right across the card body via `::after`

Area colours used as `--card-color` CSS custom property:

| Area class | Colour |
|---|---|
| `.is-backend` | `#ff6200` (orange) |
| `.is-cloud` | `#7d09d6` (purple) |
| `.is-ios` | `#0f5edb` (blue) |
| `.is-frontend` | `#12e012` (green) |

### Skill

Used on the Experience page in a **6-column grid** (responsive: 4-col at ≤1024px, 3-col at ≤640px).

Each skill is a **circular badge** built on Bulma's `figure.image.is-128x128`:
- 3px solid white border + faint outer ring shadow
- White placeholder image
- Skill name overlaid at the bottom inside the circle on a dark semi-transparent band (`bottom: 8%`)
- Hover: lifts 4px (`translateY`) with a brighter border and deeper shadow

### Homepage Avatar

Circular image (`figure.image.is-384x384`) in the hero right column:
- 4px solid white border + faint outer ring shadow
- Black placeholder image background
- Shifted slightly upward with `translateY(-3rem)`

### Project

Not yet implemented.

---

## CV

The CV download page (`/cv/download`) uses the same dark theme. Three-column layout: email form | OR divider | open-in-browser CTA button.

The inline CV view (`/cv`) is intentionally excluded from the design system for now — it targets print/PDF output and will be styled separately.

---

## Emails

Not yet implemented.

---

## TODO:
- Revisit navigation
- Add 3rd Font
- Style Project resources
