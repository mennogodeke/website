# Plan: Refactor CV Downloads → CVs + Downloads + Downloadable Concern

## Context
The current `CvDownload` resource conflates three concerns. This refactor splits them cleanly:

- **`Cv` model** — the document resource: role, language, skills, file-path helpers; `has_many :downloads`
- **`Download` model** — the transaction record: email, token, counts, `belongs_to :cv`
- **`Downloadable` concern (model)** — token/TTL/guard logic; included in `Download`
- **`CvsController`** — consolidates HTML CV rendering + PDF serving + download request form;
  has a `before_action :check_downloads_enabled` (simple private method for MVP; extractable
  to a controller concern when more controllers need it)

**Language moves to `Cv`**, not stored on `Download`. A download inherits its language through
its associated `Cv` (`download.cv.language`). For MVP, seed 3 default `Cv` records (en/nl/de).

---

## Recommendations (on your "wdyt?" items)

**PDF disposition — inline or attachment?**
Recommend `inline`. Opens in browser tab; user downloads via the browser's native PDF toolbar.
→ `send_file path, disposition: :inline`

**CV skills — text array or has_many?**
Recommend `has_many :cv_skills`. Consistent with `Job`, `Experience`, and `Project`. Easier to
query, validate, and extend in phase 2.

---

## Rename & Deletion Checklist

> Complete as you go — each item touches multiple files.

### Models
- [ ] Rename class `CvDownload` → `Download` (`app/models/download.rb`)
- [ ] Delete `app/models/cv_download.rb`
- [ ] Create `app/models/cv.rb`
- [ ] Create `app/models/cv_skill.rb`
- [ ] Create `app/models/concerns/downloadable.rb`

### Controllers
- [ ] Create `app/controllers/cvs_controller.rb`
- [ ] Delete `app/controllers/cv_downloads_controller.rb`
- [ ] Remove `#cv` and `#load_cv_data` from `PagesController`
  - Keep `#cv_preview` in `PagesController` — used by the Grover rake task

### Views
- [ ] Move `app/views/cv_downloads/new.html.erb` → `app/views/cvs/new.html.erb`
- [ ] Update form object references: `@cv_download` → `@download`
- [ ] Existing `app/views/pages/cv.html.erb` + `_cv.html.erb` → `app/views/cvs/show.html.erb`
  (keep `_cv.html.erb` as a shared partial, rendered from `cvs/show`)

### Mailer
- [ ] Rename `CvDownloadMailer` → `CvMailer` (`app/mailers/cv_mailer.rb`)
- [ ] Rename views dir: `app/views/cv_download_mailer/` → `app/views/cv_mailer/`
- [ ] Update route helpers inside mailer to use new named route
- [ ] Style the email template (noted TODO)

### Jobs
- [ ] Create `app/jobs/cv_mailer_job.rb`

### Routes (`config/routes.rb`)
- [ ] Remove: `pages#cv`, `cv_downloads#new`, `cv_downloads#create`, `cv_downloads#show`
- [ ] Add/update (see Step 6)

### Tests
- [ ] `test/controllers/cv_downloads_controller_test.rb` → `test/controllers/cvs_controller_test.rb`
- [ ] `test/models/cv_download_test.rb` → `test/models/download_test.rb`
- [ ] `test/mailers/cv_download_mailer_test.rb` → `test/mailers/cv_mailer_test.rb`
- [ ] `test/fixtures/cv_downloads.yml` → `test/fixtures/downloads.yml`
  - Add `downloadable_type: Cv` and `downloadable_id` (or `downloadable: cv_fixture_name`) to each entry
- [ ] Add `test/fixtures/cvs.yml`
- [ ] Add `test/models/cv_test.rb`
- [ ] Add `test/models/cv_skill_test.rb`

### Seeds / Content Data
- [ ] `db/seeds.rb` — add Cv seed block (3 records: en/nl/de, all `role: :default`)
- [ ] `CONTENT_DATA.yml` — no changes needed; CV seeds are hardcoded (not content-driven)
- [ ] i18n locale files — search for `cv_download.*` keys; rename to `cv.*` / `download.*`

---

## Step-by-Step Implementation

### Step 1 — Migrations (3 migrations, run in order)

**1a. Create `cvs` table**
```ruby
create_table :cvs do |t|
  t.integer :role,     null: false, default: 6  # 6 = :default
  t.integer :language, null: false, default: 0  # 0 = :en
  t.timestamps
end
```

**1b. Create `cv_skills` join table**
```ruby
create_table :cv_skills do |t|
  t.references :cv,    null: false, foreign_key: true
  t.references :skill, null: false, foreign_key: true
  t.timestamps
end
add_index :cv_skills, [:cv_id, :skill_id], unique: true
```

**1c. Alter `cv_downloads` → `downloads`**
```ruby
rename_table  :cv_downloads, :downloads
rename_column :downloads, :download_count, :count
remove_column :downloads, :role
remove_column :downloads, :language   # language moves to cvs table
remove_column :downloads, :skills
add_reference :downloads, :downloadable, polymorphic: true, null: false
# → creates downloadable_type (string) + downloadable_id (bigint) + index
# No kind column needed — downloadable_type ("Cv") already discriminates the resource type
# Note: polymorphic columns cannot have a DB-level foreign key; integrity is Rails-enforced only
```

---

### Step 2 — Downloadable Concern (model concern)

File: `app/models/concerns/downloadable.rb`

Extract from `CvDownload` into this concern:
- `has_secure_token :token`
- `TOKEN_TTL = 24.hours`, `MAX_DOWNLOADS = 3` as constants
- `before_create :set_timestamps` callback (`included do ... end`)
- `expired?`, `maxed_out?`, `usable?`
- `record_download!`

File-path helpers (`pdf_file_path`, `download_filename`) move to `Cv` model instead (since
language lives there). The concern stays generic and reusable.

---

### Step 3 — Download Model

File: `app/models/download.rb`

```ruby
class Download < ApplicationRecord
  include Downloadable

  belongs_to :downloadable, polymorphic: true

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
```

Fields retained from `CvDownload`: `email`, `token`, `requested_at`, `approved_at`,
`count` (renamed from `download_count`), `last_download_at`. New: `downloadable_type`,
`downloadable_id`. Removed: `role`, `language`, `skills`, `kind` (replaced by polymorphic type).

---

### Step 4 — Cv Model + CvSkill

`app/models/cv.rb`:
```ruby
class Cv < ApplicationRecord
  PDF_FILES      = { "en" => "storage/cv/cv.pdf", "nl" => "storage/cv/cv_nl.pdf", "de" => "storage/cv/cv_de.pdf" }.freeze
  DOWNLOAD_NAMES = { "en" => "menno_godeke_cv.pdf", "nl" => "menno_godeke_cv_nl.pdf", "de" => "menno_godeke_cv_de.pdf" }.freeze

  enum :role,     { frontend: 0, backend: 1, fullstack: 2, devops: 3, platform: 4, apps: 5, default: 6 }
  enum :language, { en: 0, nl: 1, de: 2 }

  has_many :cv_skills, dependent: :destroy
  has_many :skills, through: :cv_skills
  has_many :downloads, as: :downloadable

  def pdf_file_path   = PDF_FILES[language]
  def download_filename = DOWNLOAD_NAMES[language]
end
```

`app/models/cv_skill.rb`:
```ruby
class CvSkill < ApplicationRecord
  belongs_to :cv
  belongs_to :skill
end
```

**Seeds block to add to `db/seeds.rb`:**
```ruby
# CVs — one per language, default role
%w[en nl de].each do |lang|
  Cv.find_or_create_by!(language: lang, role: :default)
end
```

---

### Step 5 — CvsController

File: `app/controllers/cvs_controller.rb`

```
before_action :check_downloads_enabled, only: [:new, :create]

show:
  if params[:token] present
    download = Download.find_by(token: params[:token])
    redirect (with alert) unless download&.usable?
    download.record_download!
    send_file Rails.root.join(download.downloadable.pdf_file_path),
              filename: download.downloadable.download_filename,
              type: "application/pdf",
              disposition: :inline     # opens in browser tab
  else
    load CV data (moved from PagesController#load_cv_data):
      @jobs        = Job.includes(:skills).order(start_date: :desc)
      @experiences = Experience.includes(:skills).all
      @skills      = Skill.all
    render :show
  end

new:
  @download = Download.new
  set default language from I18n.locale (en fallback)

create:
  email    = params[:download][:email].strip.downcase
  language = params[:download][:language]
  cv       = Cv.find_by!(language: language, role: :default)
  existing = Download.find_by(email: email, downloadable: cv)
  if existing&.usable?
    download = existing   # reuse token (no new record)
  else
    download = Download.create!(email: email, downloadable: cv)
  end
  CvMailerJob.perform_later(download)
  redirect_to new_cv_download_path, notice: t("cv.download.sent")

private:
  def check_downloads_enabled
    redirect_to cv_path, alert: t("cv.download.disabled") unless downloads_enabled?
  end

  def downloads_enabled?
    true  # stub for MVP; read from config/credentials in phase 2
  end
```

---

### Step 6 — Routes

```ruby
scope "(:locale)", locale: /nl|de/ do
  get  "cv",                  to: "cvs#show",   as: :cv             # HTML (no token)
  get  "cv/preview",          to: "pages#cv_preview"                # keep; used by Grover task
  get  "cv/download",         to: "cvs#new",    as: :new_cv_download
  post "cv/download",         to: "cvs#create", as: :cv_downloads
  get  "cv/download/:token",  to: "cvs#show",   as: :cv_download    # PDF (with token)
  # ...rest unchanged
end
```

Both `cv` and `cv_download` route to `cvs#show`; the action branches on `params[:token]`.
Define `cv/download` routes before `cv/download/:token` so the literal segment wins.

---

### Step 7 — Background Job

File: `app/jobs/cv_mailer_job.rb`

```ruby
class CvMailerJob < ApplicationJob
  queue_as :default

  def perform(download)
    CvMailer.confirmation(download).deliver_now
  end
end
```

---

### Step 8 — CvMailer

File: `app/mailers/cv_mailer.rb` (renamed from `CvDownloadMailer`)

- Update helper: `@download_url = cv_download_url(token: download.token, host: ...)`
  (named route `cv_download` stays the same so email URLs are unchanged)
- Views dir: `app/views/cv_mailer/` (renamed)
- Style the email template (layout, branding)

---

### Step 9 — PagesController Cleanup

- Remove `#cv` action and `#load_cv_data` private method
- Keep `#cv_preview` for MVP

---

### Step 10 — Tests

Rename existing test files per checklist. Key coverage to add/update:

**`CvsControllerTest`** (renamed from `CvDownloadsControllerTest`):
- Add: `show` without token renders HTML view
- Add: `show` with valid token serves PDF inline
- Add: `show` with valid token calls `record_download!`
- Existing: token expiry, maxed-out, unknown token redirects — keep all

**`DownloadTest`** (renamed from `CvDownloadTest`):
- Update fixture references: `cv_downloads.yml` → `downloads.yml`
- Downloads now `belongs_to :cv` — fixtures need a `cv:` association

**New `CvTest`**:
- Role and language enum values
- `has_many :cv_skills` and `has_many :skills`
- `pdf_file_path` and `download_filename` return correct values

**`downloads.yml` fixture** (renamed from `cv_downloads.yml`):
- Add `cv:` reference to each fixture entry (requires `cvs.yml` fixture)

---

## Verification

1. `bin/ci` passes (rubocop + brakeman + all tests)
2. `GET /cv` — renders HTML CV page
3. `GET /cv/download` — renders download request form (language picker)
4. Submit form with email → job enqueued, email delivered, redirected with notice
5. Click token link → PDF opens inline in browser tab
6. Revisit link after max downloads → redirected with alert
7. Revisit link after TTL expiry → redirected with alert
8. `GET /(:nl)/cv/download` — locale param respected; nl CV pre-selected in form
