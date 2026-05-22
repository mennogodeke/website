# Website UI Kit — `menno.codes`

High-fidelity React recreation of the menno.codes site. Click-through, not production code.

## Files

| File | Purpose |
| --- | --- |
| `index.html` | Entry point. Loads React 18 + Babel and the JSX files below. |
| `styles.css` | Base reset, layout utilities, buttons, tags, forms, headings, highlights. |
| `pages.css` | Per-page styles (navbar, footer, home, career, experience, projects, contact). |
| `data.js` | Fake content modelled on `website/CONTENT_DATA.yml` — skills, experiences, jobs, projects. |
| `Components.jsx` | Shared atoms: `Button`, `SkillTag`, `SkillChip`, `Tag`, `Highlight`, `StatusBadge`, `ImgStub`. |
| `Navbar.jsx` | Fixed top navbar with theme toggle + locale menu, blur on scroll. |
| `Footer.jsx` | Built-with row + logotype. |
| `Home.jsx` | Hero with floating chip field, headshot stub, CTAs, footer CTA. |
| `Career.jsx` | Vertical timeline with rarity-tier role highlights and accordion entries. |
| `Experience.jsx` | Left-rail category picker + right-panel skill bars. |
| `Projects.jsx` | Alternating-direction case-study list with image stubs. |
| `Contact.jsx` | Form (name / email / message) + socials sidebar. |
| `CvDownload.jsx` | Email-gated PDF request form with a fallback "Open in browser" tile. |
| `App.jsx` | Root + the tiny state-based router (`home / career / experience / projects / contact / cv`). |

## How it differs from the real site

- **Single-page React app**, not Rails server-rendered with Turbo. Routes are stored in component state, no URL changes.
- **No locales / no theme persistence.** The locale dropdown is decorative; the theme toggle works but resets on reload.
- **Content is hard-coded** in `data.js` instead of fetched from PostgreSQL via Mobility i18n.
- **Forms don't submit anywhere.** "Send" on Contact fakes success; "Get my CV" fakes success.
- **No real images.** Headshot and project screenshots use the striped `.img-stub` placeholder.

## How to extend it

- New screen → add a JSX file, wire it into `App.jsx`'s switch, give it a `data-screen-label` on its outer wrapper.
- New tech tile → add a `skills` entry to `data.js`. The chip + tag + bar renderers all key off `accent` + `icon`.
- New rarity → don't. The five-tier ladder (common → uncommon → rare → epic → legendary) is the brand. Add or reorder usages, but don't invent tier #6.
