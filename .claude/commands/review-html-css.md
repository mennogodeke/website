Review the HTML templates and SCSS stylesheets in this Rails project against the conventions documented in CLAUDE.md. Report violations only — do not auto-fix anything.

Read CLAUDE.md first to understand the conventions, then audit the following:

**Files to check:**
- `app/assets/stylesheets/` — all `.scss` files
- `app/views/` — all `.html.erb` files

**Report violations grouped by category:**

### 1. Token discipline
- Hardcoded hex colours or raw `rgba(r, g, b, a)` values outside `_tokens.scss`
- Alpha variants not using `color-mix(in srgb, var(--token) X%, transparent)`
- Any colour that should be a token but isn't defined in `_tokens.scss`

### 2. File placement
- CSS classes defined in the wrong file (e.g. shared components in a page file, page-specific styles in `_components.scss`)
- Keyframes defined far from the component that uses them

### 3. Naming conventions
- State classes not using `.is-*` prefix (e.g. `.open`, `.active`, `.scrolled` without `is-`)
- Component classes that don't follow the established prefix scheme (`.tl-*`, `.sk-*`, `.proj-*`, `.exp-*`, `.cv-*`, `.navbar-*`, `.home-*`)

### 4. Tooltip consistency
- Any use of `data-tooltip` attribute (should be `data-tip`)
- Tooltip styles defined outside `_components.scss`

### 5. Breakpoints
- Media queries using hardcoded pixel values instead of `$bp-sm/md/lg/xl` from `_variables.scss`
- Files with media queries that are missing `@use "variables" as *`

### 6. Accessibility
- Interactive components missing correct ARIA roles (e.g. tab interfaces without `role="tabpanel"`)
- Decorative elements missing `aria-hidden="true"`
- Icon-only buttons or links missing `aria-label`
- Images missing `alt` attributes (decorative images should have `alt=""`)

### 7. Inline styles
- `style="..."` attributes setting direct CSS properties (not CSS custom properties) — these should move to stylesheets
- Note: `style="--chip-c: ..."` and similar custom property assignments are correct and should not be flagged

**Output format:**
For each violation: file path + line number, the offending code, and a one-line explanation of what convention it breaks. Group under the category headings above. If a category has no violations, write "✓ clean".
