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
- **Homepage** is the exception: full-viewport hero with a two-column grid (text left, hexagon avatar right), followed by a white stats bar

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

**Expertise card accent colours** (hover tint + glow):

| Area | Colour |
|---|---|
| Back-end | `#ff6200` (orange) |
| Cloud & DevOps | `#7d09d6` (purple) |
| iOS & macOS | `#0f5edb` (blue) |
| Front-end | `#12e012` (green) |

**Skill level colours:**

| Level | Colour |
|---|---|
| Expert | `#7d09d6` (purple) |
| Proficient | `#0f5edb` (blue) |
| Familiar | `#12e012` (green) |

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

All `.title` elements are forced uppercase, weight 900, Barlow Condensed, line-height 0.9, letter-spacing -0.01em.

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

Not yet implemented.

---

## Components/Resources

### Job

Used on the Career page. Bulma `.box` with transparent background, 25% white border, subtle white text. On hover: border brightens to 70% white, text goes full white. Transition on `border-color` and `color`.

Structure: company logo placeholder (initials) left, job title + company centre, date range right. Uses Bulma `.media` layout.

### Expertise

Used on the Experience page. Bordered card (`.expertise-card`) with a per-area CSS custom property (`--card-color`). On hover: border takes the card colour, background gets a 10% tint of the colour, and a layered glow box-shadow appears. Colour areas: backend (orange), cloud (purple), iOS (blue), frontend (green).

The first card in the grid spans full width (`.is-featured`).

### Skill

Used on the Experience page in a 6-column grid (responsive: 4-col at ≤1024px, 2-col at ≤640px). Each card has:
- A white header bar with the skill name (always visible)
- A square placeholder image below
- A coloured level overlay that slides up from the bottom on hover (familiar/proficient/expert)
- Border colour on hover matches the skill level colour

### Project

Not yet implemented.

---

## CV

The CV download page (`/cv/download`) uses the same dark theme. Three-column layout: email form | OR divider | open-in-browser CTA button.

The inline CV view (`/cv`) is intentionally excluded from the design system for now — it targets print/PDF output and will be styled separately.

---

## Emails

Not yet implemented.
