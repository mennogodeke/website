# Project Overview

---

## Controllers and Routes

All routes are wrapped in a locale scope (`/nl/…` or `/de/…`), defaulting to English when no locale prefix is present.

```
GET /             → pages#home
GET /home         → pages#home
GET /experience   → experience#show
GET /jobs         → jobs#index          ← Career page
GET /projects     → projects#index
GET /projects/:id → projects#show
GET /contact      → pages#contact
GET /design-preview → pages#design_preview
```

`PagesController` serves static pages (home, contact, cv, cv_preview, design_preview). `ExperienceController#show` loads `@experiences` (with skills eager-loaded) and `@skills`.

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
Fields: `title` (i18n: `title_en`, `title_nl`, `title_de`), `company` (string), `description` (i18n: `description_en`, `description_nl`, `description_de`), `start_date` (date), `end_date` (date, nullable), `logo` (string), `accent` (string).
Validations: `title`, `company`, `start_date` are required.
Associations: `has_many :skills, through: :job_skills`.
i18n: `translates :title, :description` (Mobility).

### Experience ✓
Fields: `name` (string), `description` (i18n: `description_en`, `description_nl`, `description_de`), `years_of_experience` (integer), `category` (integer enum), `icon` (string).
`accent` is a computed method derived from `years_of_experience` (common → legendary).
Validations: `name`, `years_of_experience` are required.
Ordering: `default_scope` orders by `years_of_experience DESC`.
Associations: `has_many :skills, through: :experience_skills`.
Enum: `category` — `frontend`, `backend`, `fullstack`, `devops`, `platform`, `apps`, `programming_language`, `other`.
i18n: `translates :description` (Mobility).

### Skill ✓
Fields: `name` (string), `description` (i18n: `description_en`, `description_nl`, `description_de`), `level` (integer enum), `icon` (string), `accent` (string).
Validations: `name`, `level` are required.
Associations: `has_many :experiences, through: :experience_skills`, `has_many :jobs, through: :job_skills`, `has_many :projects, through: :project_skills`.
Enum: `level` — `familiar: 1`, `proficient: 2`, `expert: 3`.
i18n: `translates :description` (Mobility).

### ExperienceSkill ✓
Join table between `Experience` and `Skill`. Extra field: `info` (text).

### JobSkill ✓
Join table between `Job` and `Skill`. Extra fields: `category` (integer), `info` (text).

### Project ✓
Fields: `name` (string), `description` (i18n: `description_en`, `description_nl`, `description_de`), `url` (string, optional), `repo_url` (string, optional), `position` (integer), `year` (integer), `accent` (string), `image` (string).
Validations: `name` is required. `url` and `repo_url` must be valid HTTP/HTTPS URLs if present.
Ordering: `default_scope` orders by `position ASC`.
Associations: `has_many :skills, through: :project_skills`.
i18n: `translates :description` (Mobility).

### ProjectSkill ✓
Join table between `Project` and `Skill`. Extra field: `info` (text).

### CvDownload ✓
Fields: `email` (string), `token` (string, unique), `requested_at` (datetime), `approved_at` (datetime), `download_count` (integer, default 0), `last_download_at` (datetime, nullable), `role` (integer enum), `language` (integer enum), `skills` (text array).
Token is generated via `has_secure_token` and expires after 24 hours. `approved_at` is auto-set on creation (no manual approval yet). `download_count` is incremented and `last_download_at` is updated on each download.
Enum: `role` — `frontend`, `backend`, `fullstack`, `devops`, `platform`, `apps`, `default`.
Enum: `language` — `en`, `nl`, `de`.

**Future:** Add `denied_at` and admin approval/denial flow once User authentication is implemented.

---

## CV(To Be Reviewed/Reimplemented)

### Generation
`PagesController#cv` renders the CV as an HTML page using Job, Skill, and Experience data. `PagesController#cv_preview` renders the same view with the dedicated CV layout (intended for development/print preview).

The Rake task `bin/rails cv:generate` generates the PDF: it boots a temporary local Rails server on port 3099, hits `/cv/preview` via Grover (Puppeteer/Chrome), and writes the output to `storage/cv/cv.pdf`. Requires Chrome in the Docker image.

### Download flow
Visitors request the CV via an email confirmation flow through `CvDownloadsController`:
1. Visitor submits their email on `CvDownloads#new`
2. A `CvDownload` record is created (auto-approved for now) and a confirmation email is sent with a signed link that expires after 24h
3. Visitor clicks the link → `CvDownloads#show` validates the token, triggers the PDF download, and increments `download_count`

**Future:** Add admin approval/denial flow alongside the `/admin` backend once User authentication is implemented.

---

## Pages

### Home
The landing page, also serving as the traditional "About" page.

- Big title/hero (e.g. "Freelance Software Engineer" or "Web & App Development") with name
- Professional headshot / placeholder image
- Short personal introduction / bio
- CTAs and hints pointing visitors to other sections of the site

### Experience ✓
Showcases broad areas of technical knowledge (`Experience` model) alongside individual skills (`Skill` model).

### Career ✓
A chronological list of jobs and positions, ordered from most recent to oldest. Rendered dynamically from the `Job` model via `JobsController`. Each entry displays role, company, dates, and description. Seeded with 5 real entries.

Entries:
1. Senior Software Engineer @ Kape Technologies [Feb 2022 – Jan 2026]
2. Software Engineer @ Kape Technologies [Feb 2019 – Jan 2022]
3. Junior Software Engineer @ ZenGuard [Aug 2017 – Jan 2019]
4. Software Engineering Intern @ ZenGuard [Feb 2017 – Jul 2017]
5. Software Engineering Intern @ Shopboostr [Jun 2016 – Dec 2016]

### Projects ✓
A portfolio page listing the projects I've worked on. Each project has a dedicated detail/show page. Rendered dynamically from the `Project` model via `ProjectsController`.

### Contact
A contact page with links to socials (GitHub, LinkedIn, Slack, Discord, email) and a contact form.

Note: Page label may change (e.g. "Get in touch", "Let's work together").
