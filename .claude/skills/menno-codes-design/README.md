# Menno.Codes Design System

> A personal-portfolio design system with a loot-rarity twist.

This is the design system for **menno.codes** — the personal portfolio and interactive CV of Menno Godeke, a freelance/permanent full-stack software engineer based in Germany. The site is a Ruby on Rails 8.1 app with a custom CSS design system (no Tailwind, no Bulma, no framework). Everything here mirrors the visual + content vocabulary already living in that codebase, so a design agent can produce on-brand mocks, slides, or new screens without reinventing anything.

## Sources

- **Codebase:** `website/` (attached locally) — Rails 8.1.3, Ruby 3.4.7, custom CSS via `dartsass-rails`. Read-only.
- Key files referenced when building this system:
  - `website/app/assets/stylesheets/_tokens.scss` — the canonical color + type token list
  - `website/app/assets/stylesheets/_typography.scss` — semantic h1–h6 + rarity highlight classes
  - `website/app/assets/stylesheets/_components.scss` — buttons, tags, form fields, tooltips
  - `website/app/assets/stylesheets/_navbar.scss` / `_footer.scss` / `_home.scss` / `_career.scss` / `_experience.scss` / `_projects.scss`
  - `website/app/views/pages/design_preview.html.erb` — an in-repo component showcase route (`/design-preview`)
  - `website/CONTENT_DATA.yml` — production copy for skills, experiences, jobs, projects (i18n: en / nl / de)
  - `website/PROJECT_OVERVIEW.md` and `website/CLAUDE.md` — product spec and tone guidance

If the reader has access to those files, they are the ground truth. Anything here is a derived, agent-readable summary.

---

## What this site _is_

A single-person portfolio for **Menno Godeke** (handle: `MENNO.CODES`), aimed at two audiences:

1. **Recruiters** screening for permanent senior back-end / full-stack roles.
2. **Freelance clients** who want to hire directly.

The site has five public surfaces, all rendered server-side from Rails (`/`, `/jobs`, `/experience`, `/projects`, `/contact`) plus a `/cv` HTML view and an email-gated PDF CV download flow.

There is **one product** in scope: the marketing-style portfolio website. No app, no docs site, no admin dashboard yet (those are noted as future work in `PROJECT_OVERVIEW.md`).

---

## The big idea: skills as loot

The single most distinctive thing about this brand is the **video-game loot-rarity metaphor** running through every page:

- Skills have a `level` of `familiar` / `proficient` / `expert`.
- Job entries and skill highlights are tagged with a **rarity tier**:
  `common → uncommon → rare → epic → legendary` — gray / green / blue / purple / orange, in classic RPG/Hearthstone palette order.
- Years of experience are stamped onto cards in display-font as big numerals (`8YR`, `10`).
- The dark theme reads like a character sheet; the light theme reads like a tactical brief.

Every other visual decision (sharp corners, monospace meta-labels, paint-stroke highlights behind headings, devicon chip-fields drifting in the background of the hero) feeds that metaphor.

---

## CONTENT FUNDAMENTALS

### Voice

- **First person, singular.** Always “I”, never “we”. The site is one person's site.
- **Second-person, casual.** Addresses the reader as "you" when relevant ("my inbox is open").
- **Personal and human, not corporate.** From the source `CLAUDE.md`: "the kind of person you'd want to work with, not just hire." Informal but competent.
- **Dry humour is fine, never forced.** It lives in the descriptive copy, not in the chrome:
  - on AWS: "_…and enough IAM policies to fill a small novel._"
  - on Terraform: "_…because clicking through the AWS console is not a deployment strategy._"
  - on Git: "_…branches, rebases, and the occasional panic-driven force-push._"
  - on payment systems: "_…systems that handle real money for real users — and haven't caught fire yet._"

### Casing

- **Body copy:** sentence case. Normal capitalization. Em-dashes (—) used liberally for asides.
- **Headings (h1):** the display font (Anton) is naturally uppercase, but text is usually written in title or sentence case in the source — the font does the shouting.
- **Nav links + section titles in the navbar:** UPPERCASE via `.upcase`.
- **Mono meta-labels:** UPPERCASE with `letter-spacing: 0.06–0.10em` (`STATUS · AVAILABLE NOW`, `SKILLS · ORDERED BY PROFICIENCY`).
- **Year stamps:** UPPERCASE with `YR` suffix (`8YR`, `10YR`).

### Punctuation conventions

- **Em-dash —** for asides and clauses-mid-thought. Used heavily.
- **Middle dot ·** as a separator in meta lines: `8yr Back-End · 5yr DevOps · 3yr Cloud`, `Senior · Available now`.
- **Arrow →** in CTAs: `Get My CV →`, `Send message →`. No bare "Submit".
- **Ampersand &** in section names: `DevOps & Automation`, `Cloud & Infrastructure`.

### Emoji

- **Minimal but present.** A waving hand "Hi, I'm Menno 👋" appears in the home translation key. No emoji used decoratively in body copy.
- **Status uses dots and devicons,** not emoji — a blinking green circle for "Open to work", devicon glyphs for tech.
- **Don't add emoji** to anything new unless mirroring that one greeting.

### Phrase library (copy this voice)

| Use | Example |
| --- | --- |
| Greeting | "Hi, I'm Menno" / "Hi, I'm Menno 👋" |
| Headline | "Web, App and Platform Developer." |
| Sub-headline | "10+ Years of experience" |
| Status badge | "Looking for opportunities · Remote or on location" / "Open to work" |
| Hero blurb (about) | "My little corner of the internet — a personal portfolio and interactive CV where you can explore my work, browse my experience, and grab my CV if you like what you see." |
| Bio one-liner | "10 years building back-end systems, full-stack web apps, and developer tooling. Ruby on Rails at the core. Everything else as needed." |
| CTA primary | "Get My CV →" |
| CTA secondary | "Get in Touch" |
| Closer | "Open to work. Let's talk." |
| Contact intro | "Have a project in mind, or just want to say hi? Either way, my inbox is open." |
| Project CTA | "View case study →" |

### What to avoid

- Generic SaaS phrases ("Unlock your potential", "Transform your business").
- "Crafted with" / "Curated" / "Beautifully designed". Too precious.
- Bullet lists of vague verbs ("Leveraging", "Empowering").
- Exclamation points in body copy. The voice is dry.
- Calling anything "an experience" or "a journey".

---

## VISUAL FOUNDATIONS

### Colors

- **Primary accent: electric yellow `#f5e90c`.** Used aggressively — full-bleed h1 paint-stroke, primary button background, hover underline under nav links, focus ring, link hover, the entire CTA system. Always paired with the deep navy `#0b1729` as its invert.
- **Backgrounds run dark by default** (`color-scheme: dark` declared at `:root`). Page base is `#0b1729` (deep navy, almost black), alt surface `#0d1e38`. The light theme inverts to `#f4f3ef` warm paper + `#eceae5` alt — never pure white.
- **The body is gradient-washed.** A 4-layer stack: two radial "shine" highlights (top-right, bottom-left), one "glow" (top-center, tinted purple in dark mode `rgba(100, 60, 255, 0.30)`), and a vertical `linear-gradient(#00020f → #010c2a)` base. `background-attachment: fixed` so it doesn't scroll. **Every new page should sit on this body backdrop.**
- **Cards use translucent fill** (`rgba(255,255,255,0.04)` in dark, `rgba(11,23,41,0.04)` in light) over the gradient body, with a hairline border. The card itself is never opaque.
- **Rarity tiers are the second palette,** used semantically (not just decoratively): legendary > epic > rare > uncommon > common. Each has a `from / mid / to` gradient for use as a 160deg paint-stroke behind text. Apply the highest rarity to the most recent / most important item in any list (e.g. the topmost job in the career timeline gets `.highlight-legendary`, the next down `.highlight-epic`, then `rare`, `uncommon`, `common`).

### Typography

- **Anton** — display. Tall, narrow, bold sans. All caps by default. Used for h1, big numerals (years of experience), nav logo, button labels.
- **Anton SC** — small-caps version. Used for h2–h6. Pairs with Anton when you need a heading that's clearly subordinate but still has the same skeleton.
- **DM Sans** — body. 400/500/600/700 weights loaded. Used for paragraphs, form input, nav links, descriptions.
- **System monospace** (`ui-monospace, Cascadia Code, Fira Mono`) — meta labels, year stamps on the career timeline, tooltips, tags styled `.skill-tag`. Always small (`0.6–0.7rem`), always uppercase, always wide letter-spacing (`0.05–0.10em`).
- **The h1 is loud:** `clamp(3rem, 7vw, 5rem)`, uppercase Anton, sitting on a yellow paint-stroke (`box-decoration-break: clone` so the stroke clones across line wraps). Use `.hero` on h1 to suppress the paint-stroke when it would overpower (the homepage title `MENNO.CODES`).
- **Bigger still on hero:** `.home-site-title` is `clamp(5rem, 12vw, 9rem)` and `white-space: nowrap`. The title is meant to dominate the fold.

### Backgrounds

- **No imagery in chrome.** No hero photo, no full-bleed background pattern, no repeating texture. The brand's "background" _is_ the body gradient + the drifting devicon chip field on the home hero.
- **The devicon chip field is unique to this site.** On `/`, 16 floating circles drift gently around the hero, each carrying one devicon glyph (Ruby, Rails, Docker, Go, etc.), tinted with that tech's brand color at 35% border / 8% fill / 80% icon — animated with `chip-drift-a/b/c/d` over 8–14s on infinite alternate. Use sparingly — it's a homepage-only flourish.
- **Card "image placeholders"** are striped, never solid. `.img-stub` is a `135deg` repeating linear gradient of `--color-stripe` over `--color-bg-card`, with the word "screenshot" in uppercase mono — used wherever a real image hasn't been provided yet.

### Animation

- **Easing default: `cubic-bezier(.2, .7, .2, 1)`** for prominent motion (progress bars). Otherwise `ease` / `ease-out` for hover transitions.
- **Durations:** `0.15s` for hovers, `0.2s` for state changes, `0.32s` for opening/closing accordions, `0.4s` for navbar background fade-in on scroll, `0.6s` for progress-bar fills, `8–14s` for the drifting chip field.
- **No bounces.** No spring. No dramatic entrances. Animation is utilitarian — fade-up on initial load (`fade-up` keyframe), `badge-blink` (opacity 1 ↔ 0.3 over 2s) for the "available now" dot, slow chip drift on the hero.
- **Reduce motion is respected by absence rather than intent** — i.e. the animations are all subtle enough they don't need to be opted out of. Don't add aggressive motion.

### Hover states

- **Buttons:** background and text colors invert. Primary fills yellow → on hover goes transparent with yellow text. Secondary inverts the same way. Default (ghost) tightens border from `border-2` → `text`.
- **Nav links:** underline (`scaleX(0) → scaleX(1)`) animates in beneath the link in primary yellow over 0.2s.
- **Career timeline entries:** padding-left grows from `56px → 56px + 8px` and the left border-left accent appears in primary yellow. The whole entry brightens (`color: text`).
- **Project rows:** padding-left grows by 8px, image scales `1.02`, "View case study →" turns yellow.
- **Skill chips/tags:** no scale, no shadow. The accent border and background brighten slightly. Tooltip pops above.

### Press / focus

- **Press:** `:active { opacity: 0.8 }` on buttons. No shrink, no shadow change.
- **Focus:** `outline: 2px solid var(--color-primary); outline-offset: 2px` — yellow ring, always. Inputs also get a `box-shadow: 0 0 0 2px rgba(245,233,12,0.25)` on focus to soften it.

### Borders, corners, shadows

- **Corner radius: 0 by default.** This is a sharp-edged system. The only exceptions are:
  - `border-radius: 50%` on dots, avatars, the headshot, floating chips.
  - `border-radius: 999px` (pill) on `.home-badge` (the "open to work" capsule) and `.skill-tag`.
- **Border weights:** 1px hairline for cards (`--color-border`), 1.5px on form inputs, 2px on buttons, 4px on the experience-panel top accent. (The codebase also uses a 3px left edge on the career timeline as an open-state indicator — handled there as a component detail, not a system-wide token.)
- **No drop shadows on content.** The whole UI is essentially flat. Two exceptions:
  - `.locale-dropdown-menu` and `.tooltip` (`box-shadow: 0 8px 24px rgba(0,0,0,0.5)` / `0 4px 12px rgba(0,0,0,0.3)`) — only floating surfaces.
  - The scrolled navbar gets `box-shadow: 0 1px 0 var(--color-navbar-highlight), 0 4px 24px rgba(0,0,0,0.4)`.
- **Glow / inner shadow systems: none.** No neon, no inset highlights.

### Transparency + blur

- **Backdrop-blur is reserved for floating chrome.** `backdrop-filter: blur(10–12px)` on the scrolled navbar, the mobile menu, the locale dropdown. Nowhere else.
- **Card backgrounds are translucent (~4% white over dark)** to let the body gradient bleed through.
- **`color-mix(in srgb, var(--chip-c) X%, transparent)`** is used to derive accent-tinted chip backgrounds (`8%` fill, `35%` border, `80%` icon color). Use this when you need an accent-tinted element without inventing a new var.

### Imagery vibe

- **There isn't much imagery to work with yet.** The site uses placeholders (`.img-stub`, `.home-headshot.img-stub`) where photos should go. Real images on hand are company logos from past employers (Kape, PIA, ExpressVPN, CyberGhost, ZenMate) — bright corporate marks against white. Reproduce these on dark via the `.tl-logo` treatment (small monogram square with hairline border) rather than embedding the full logo.
- **Imagery should be cool-toned, dark, and editorial when added.** Think tactical-brief, not warm lifestyle photography. The dominant color palette is deep navy and electric yellow — any photo brought in should sit alongside that without fighting it.

### Layout rules

- **Fixed navbar (56px tall), no fixed footer.** The main content gets `padding-top: var(--nav-h)` to clear it.
- **Container max-width is 1280px** (`--max-w`) with a `1.5rem` gutter. Pages are designed for ~1280px wide reading length; long-form content stays inside that.
- **`section` padding is 4rem block** by default, 5rem for `.section.is-medium`.
- **Grid is the workhorse:** experience uses 320px + 1fr, projects alternate 1fr / 1.3fr, hero is 1.5fr + 1fr. There's no 12-column system — each surface gets a custom grid sized to its content.

---

## ICONOGRAPHY

The site uses **two icon libraries side by side**, plus one tiny brand mark.

### Devicons (tech stack)

- **Devicon v2.16.0** via jsDelivr CDN, classes like `devicon-ruby-plain`, `devicon-rails-plain`, `devicon-docker-plain`, etc. Used for any tech-stack reference — skill chips, language cards, the floating chip field on the home hero, the footer "Built with:" row.
- Add `.colored` (e.g. `devicon-ruby-plain colored`) to render the brand's true colors instead of the muted default; the codebase uses this in the footer.
- Each tech has a paired brand-accent hex stored as the skill's `accent` value in `CONTENT_DATA.yml` (Ruby `#CC342D`, Rails `#CC0000`, Go `#00ADD8`, etc.). When rendering a chip, pass it through CSS as `--chip-c: <accent>` so the chip's border/background/icon all derive via `color-mix()`.

### Font Awesome 6.5.0

- **Free icons only.** Loaded from cdnjs. Used for categories, UI affordances, and the few cases where Devicon doesn't have a matching mark.
- Common usages in the codebase:
  - `fa-solid fa-arrow-right` — inside CTAs after the label
  - `fa-solid fa-chevron-down` — accordion toggle on career entries
  - `fa-solid fa-server`, `fa-solid fa-layer-group`, `fa-solid fa-gears`, `fa-solid fa-cloud`, `fa-brands fa-apple`, `fa-solid fa-cubes` — Experience category icons
  - `fa-brands fa-github`, `fa-brands fa-linkedin-in`, `fa-brands fa-discord`, `fa-brands fa-slack`, `fa-solid fa-envelope` — Contact page socials
  - `fa-solid fa-credit-card`, `fa-solid fa-file-invoice-dollar`, `fa-solid fa-language` — fallback icons when no Devicon exists (Adyen, ChargeBee, spoken languages)
  - `fa-solid fa-sun` / `fa-solid fa-moon` — theme toggle
  - `fa-solid fa-robot` — Claude attribution in footer (color override `#cc785c`)

### Flag-icons 7.2.3

- Used for the language switcher in the navbar. CSS classes like `.fi-gb`, `.fi-nl`, `.fi-de` rendered as `border-radius: 50%` flag chips. Don't use for anything else.

### Emoji

- **Used in copy, not as UI icons.** Exactly one occurrence in the i18n files: "Hi, I'm Menno 👋". No 🚀, no ✨, no ✅. If you reach for an emoji as a UI element, use a Font Awesome or Devicon glyph instead.

### Unicode characters as icons

- **Arrows: `→`** in CTAs (`Get My CV →`), `←` for navigate-back, `↗` to mark external links in the project list, `›` as chevron on the experience rail.
- **Middle dot `·`** as a separator (see Punctuation).
- **Em-dash `—`** in copy.

### Brand mark / logo

- The site doesn't have a graphical logo. **The logotype `MENNO.CODES` set in Anton bold uppercase _is_ the logo.** Sizes: 1.35rem in the navbar, 0.85rem in the footer.
- `public/icon.svg` ships in the codebase but is a placeholder red circle — not the real favicon. Treat it as missing.

### Company logos

The 5 employer logos used on the career page are available in `assets/logos/`:

| Company | Files |
| --- | --- |
| Kape Technologies | `kape-icon.jpeg`, `kape-logo.png` |
| Private Internet Access (PIA) | `pia-icon.png`, `pia-logo.png` |
| ExpressVPN | `express-vpn-icon.png`, `express-vpn-logo.png` |
| CyberGhost | `cyberghost-icon.jpg`, `cyberghost-logo.png` |
| ZenMate (ZenGuard) | `zenmate-icon.png`, `zenmate-logo.png` |

In the live site these are rendered as monogram squares (initials in mono font on a card-style background), not the full logos. The full files are kept here in case a design needs them.

---

## Caveats / known gaps

- **No real headshot.** Wherever you see "headshot", insert an `.img-stub` placeholder.
- **No real project screenshots.** Same — use `.img-stub`.
- **No custom favicon.** `assets/icon.svg` is a placeholder.
- **Fonts ship locally now.** Anton, Anton SC, and DM Sans (regular + italic) are bundled under `fonts/` and wired up via `@font-face` at the top of `colors_and_type.css`. The source codebase still loads them from Google Fonts.

---

## Index — what's in this folder

| Path | Purpose |
| --- | --- |
| `README.md` | This file. |
| `SKILL.md` | Agent-Skills compatible front-matter + entry point. |
| `colors_and_type.css` | Single import for tokens + semantic h1–h6, p, rarity highlights. |
| `fonts/` | Bundled brand fonts (Anton, Anton SC, DM Sans variable + italic). |
| `assets/` | Company logos, hero background, placeholder favicon. |
| `preview/` | Small one-concept reference cards that populate the Design System tab. |
| `ui_kits/website/` | High-fidelity recreations of the menno.codes pages (home, career, experience, projects, contact, cv). Click-through `index.html` + factored JSX components. |
