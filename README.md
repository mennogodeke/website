# Personal Website

My personal portfolio / CV website to showcase the skills and knowledge i've gained over the years, the jobs i've had and the projects i've built. Additionally there should be the option to download my CV.

See [PROJECT_OVERVIEW.md](PROJECT_OVERVIEW.md) for the full product spec.

## Stack
- Ruby on Rails 8.1.3
- Ruby 3.4.7
- Hotwire (Turbo + Stimulus) · Importmap · Propshaft
- Custom CSS/SCSS design system (`dartsass-rails`, no external framework)
- PostgreSQL (via `pg` gem)
- Docker · Kamal (deployment)

---

## Development Environment
- PostgreSQL runs in Docker via `docker compose up`
- Rails app runs locally via `bin/dev`
- `docker-compose.yml` is for local dev only — Kamal handles production
- Default local DB credentials: user `website`, password `password`, host `localhost`

---

## Deployments and CI/CD
- **CI:** GitHub Actions — 4 jobs: `scan_ruby` (Brakeman + bundler-audit), `scan_js` (importmap audit), `lint` (RuboCop), `test` (Minitest with PostgreSQL service container)
- **Deployment:** Kamal — builds a production Docker image and deploys to the target server
- **Production DB:** PostgreSQL as a Kamal accessory; connection via `DATABASE_URL` secret
- System test job exists in CI but is disabled (`if: false`) until system tests are implemented
