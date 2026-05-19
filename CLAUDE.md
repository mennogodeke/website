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

**Stack:** Rails 8.1.3 · Ruby 3.4.7 · Hotwire (Turbo + Stimulus) · Importmap · Propshaft · Bulma CSS

No Node.js build step — JavaScript is managed via importmap (`config/importmap.rb`). Assets go through Propshaft.

**Deployment:** Docker → Kamal. The `bin/ci` script mirrors what GitHub Actions runs on push.

## Key Conventions

- Ruby style follows `rubocop-rails-omakase` (inherited in `.rubocop.yml`)
- Stimulus controllers live in `app/javascript/controllers/`
- CSS lives in `app/assets/stylesheets/` via manifest
- **Bulma customisation** — extend via CSS cascade order (our stylesheet loads after `bulma.min.css`), scoped selectors (e.g. `.career-list .box`), and `:root` custom properties. Avoid `!important`; rely on specificity or load order instead. See `DESIGN.md` for the full design system.

## Content

### Audience
Both recruiters screening for permanent roles and freelance clients looking to hire directly.
Preference is toward permanent employment, but open to both. No specific industry focus.

### Tone
Personal and human rather than corporate. Informal but competent — the kind of person you'd
want to work with, not just hire. Occasional dry humour is fine; never forced.
Icon library: Devicons (tech stack) + Font Awesome (categories/UI).
(Further tone refinement TBD — revisit once first page copy is drafted.)