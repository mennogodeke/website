# Project Overview

See also: [DESIGN.md](DESIGN.md) · [CONTENT.md](CONTENT.md)

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

### Expertise ✓
Fields: `name` (string), `description` (text), `years_of_experience` (integer).
Validations: `name`, `years_of_experience` are required.
Ordering: `default_scope` orders by `years_of_experience DESC`.
Associations: `has_many :skills, through: :expertise_skills`.

### Skill ✓
Fields: `name` (string), `description` (text), `level` (integer enum: `familiar: 1`, `proficient: 2`, `expert: 3`).
Validations: `name`, `level` are required.
Associations: `has_many :expertises, through: :expertise_skills`, `has_many :jobs, through: :job_skills`, `has_many :projects, through: :project_skills`.

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


## Pages

### Home
The landing page, also serving as the traditional "About" page.

- Big title/hero (e.g. "Freelance Software Engineer" or "Web & App Development") with name
- Professional headshot / placeholder image
- Short personal introduction / bio
- CTAs and hints pointing visitors to other sections of the site

### Experience
A combination of two sub-resources: **Expertise** and **Skills**.

#### Expertise ✓
Showcases broad areas of knowledge and experience in software engineering, each with a short summary of the type of work and technologies involved. Rendered dynamically from the `Expertise` model on the experience page, ordered by `years_of_experience DESC`. Associated skills are shown as tags.

#### Skills
A grid/collection of specific technologies with an indication of proficiency level (1–3 scale: familiar/proficient/expert). `Skill` model is implemented and seeded; the view renders "Coming soon." Layout TBD.

Open question: Should non-engineering skills also be listed here? (e.g. spoken languages, SCRUM/Agile, JIRA)

Idea: Skills displayed as a grid where tile size reflects proficiency level (xs–xl) and related skills are clustered together.

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
