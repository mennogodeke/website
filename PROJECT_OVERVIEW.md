# Project Overview

See also: [DESIGN.md](DESIGN.md) · [CONTENT.md](CONTENT.md)

---

## CV

### Generation
`PagesController#cv` renders the CV as an HTML page using Job, Skill, and Expertise data. `PagesController#cv_preview` renders the same view with the dedicated CV layout (intended for development/print preview).

The Rake task `bin/rails cv:generate` generates the PDF: it boots a temporary local Rails server on port 3099, hits `/cv/preview` via Grover (Puppeteer/Chrome), and writes the output to `storage/cv/cv.pdf`. Requires Chrome in the Docker image.

### Download flow
Visitors request the CV via an email confirmation flow through `CvDownloadsController`:
1. Visitor submits their email on `CvDownloads#new`
2. A `CvDownload` record is created (auto-approved for now) and a confirmation email is sent with a signed link that expires after 24h
3. Visitor clicks the link → `CvDownloads#show` validates the token, triggers the PDF download, and increments `download_count`

**Future:** Add admin approval/denial flow alongside the `/admin` backend once User authentication is implemented.

---

## Controllers and Routes

```
GET /             → pages#home
GET /home         → pages#home
GET /experience   → experience#show
GET /jobs         → jobs#index          ← Career page
GET /projects     → projects#index
GET /projects/:id → projects#show
GET /contact      → pages#contact
```

`PagesController` serves static pages (home, contact). `ExperienceController#show` loads `@expertises` (with skills eager-loaded) and `@skills`.

```
GET  /cv                 → pages#cv             ← HTML CV view
GET  /cv/preview         → pages#cv_preview     ← CV layout preview
GET  /cv/download        → cv_downloads#new     ← Request form
POST /cv/download        → cv_downloads#create  ← Submit email
GET  /cv/download/:token → cv_downloads#show    ← Confirm & trigger download
```

---

## Models

### Job ✓
Fields: `title` (string), `company` (string), `description` (text), `start_date` (date), `end_date` (date, nullable).
Validations: `title`, `company`, `start_date` are required.
Associations: `has_many :skills, through: :job_skills`.
Seeded with 5 real entries via `db/seeds.rb`.

### Expertise ✓
Fields: `name` (string), `description` (text), `years_of_experience` (integer).
Validations: `name`, `years_of_experience` are required.
Ordering: `default_scope` orders by `years_of_experience DESC`.
Associations: `has_many :skills, through: :expertise_skills`.
Seeded with 5 entries via `db/seeds.rb`.

### Skill ✓
Fields: `name` (string), `description` (text), `level` (integer enum: `familiar: 1`, `proficient: 2`, `expert: 3`).
Validations: `name`, `level` are required.
Associations: `has_many :expertises, through: :expertise_skills`, `has_many :jobs, through: :job_skills`, `has_many :projects, through: :project_skills`.
Seeded with 15 entries via `db/seeds.rb`.

### ExpertiseSkill ✓
Join table between `Expertise` and `Skill`. No extra fields.

### JobSkill ✓
Join table between `Job` and `Skill`. No extra fields.

### Project ✓
Fields: `name` (string), `description` (text), `url` (string, optional), `repo_url` (string, optional), `position` (integer), `year` (integer).
Validations: `name` is required. `url` and `repo_url` must be valid HTTP/HTTPS URLs if present.
Ordering: `default_scope` orders by `position ASC`.
Associations: `has_many :skills, through: :project_skills`.

### ProjectSkill ✓
Join table between `Project` and `Skill`. No extra fields.

### CvDownload ✓
Fields: `email` (string), `token` (string, unique), `requested_at` (datetime), `approved_at` (datetime), `download_count` (integer), `last_download_at` (datetime, nullable).
Token is generated via `has_secure_token` and expires after 24 hours. `approved_at` is auto-set on creation (no manual approval yet). `download_count` is incremented and `last_download_at` is updated on each download.

**Future:** Add `denied_at` and admin approval/denial flow once User authentication is implemented.
