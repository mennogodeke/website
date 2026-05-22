---
name: menno-codes-design
description: Use this skill to generate well-branded interfaces and assets for menno.codes (Menno Godeke's personal portfolio), either for production or throwaway prototypes/mocks/etc. Contains essential design guidelines, colors, type, fonts, assets, and UI kit components for prototyping.
user-invocable: true
---

# menno.codes Design Skill

Read the `README.md` file within this skill first — it covers the brand context, content fundamentals, visual foundations, and iconography. Then explore the other available files in the skill folder:

- `colors_and_type.css` — drop-in CSS variables + element defaults (h1–h6, p, highlight-\*).
- `fonts/` — Anton, Anton SC, and DM Sans as `.ttf`.
- `assets/` — past-employer logos (Kape, PIA, ExpressVPN, CyberGhost, ZenMate), a placeholder favicon.
- `preview/` — small one-concept reference cards (type, colors, components, brand).
- `ui_kits/website/` — a React click-through of the live site. Lift components from there when building a new screen.

## When invoked

If creating **visual artifacts** (slides, mocks, throwaway prototypes), copy the assets you need into the new artifact's folder and create static HTML files for the user to view. Import `colors_and_type.css` to get the tokens for free.

If working on **production code** (the Rails app at `website/`), you can copy assets and read the rules here to become an expert in designing with this brand. The canonical token list is `app/assets/stylesheets/_tokens.scss` in the source codebase — this skill mirrors it but the source wins on conflicts.

If the user invokes this skill without any other guidance, ask them what they want to build or design, ask follow-up questions, and act as an expert designer who outputs HTML artifacts _or_ production code, depending on the need.

## House style — the short version

- **The brand is `MENNO.CODES`** — one person's portfolio, set in Anton bold uppercase. No graphical logo.
- **Loot-rarity is the metaphor.** Common / Uncommon / Rare / Epic / Legendary. Use this ladder semantically when ranking anything in a list — the most recent or most important entry gets the highest rarity.
- **Sharp corners by default.** `border-radius: 0` everywhere except dots, avatars, and the "open to work" pill / skill-tag (`999px`).
- **One accent: electric yellow `#f5e90c` on deep navy `#0b1729`.** Don't introduce a third brand color.
- **Voice: dry, first-person, em-dash-heavy.** "I" not "we". CTAs end in `→`. Examples and a phrase library are in `README.md`.
- **Icons: Devicon for tech, Font Awesome for UI.** Both via CDN. Don't draw your own SVG glyphs — copy the right class instead.
