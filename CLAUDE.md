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
