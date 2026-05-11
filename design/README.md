## Project
- Uses Bulma CSS
- Keeps Javascript to a minimum

---

## Data Models and Resources

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
