# Personal Website
My personal portfolio / CV website to showcase the skills and knowledge i've gained over the years, the jobs i've had and the projects i've built. Additionally there should be the option to download my CV.

## Stack
- Ruby on Rails 8.1.3
- Ruby 3.4.7
- Bulma CSS (vendored as `bulma.min.css`)
- Database: not yet added

---

## Navigation
No dropdowns. Flat navigation bar with the following items:

```
[home, experience, career, projects, contact, download cv]
```

Notes:
- The label "contact" is not set in stone — alternatives like "Get in touch" or "Let's work together" are on the table
- The order of "contact" and "download cv" is also still open

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

#### Expertise
Showcases broad areas of knowledge and experience in software engineering, each with a short summary of the type of work and technologies involved.

Examples:
- Front-end, 3+ Years — JavaScript, TypeScript, Vue.js, HTML5, CSS3
- Back-end, 8+ Years — Ruby on Rails, payment systems (Stripe, ChargeBee, Adyen), TDD, CI/CD
- (Native) App Development, 4+ Years — Swift, Xcode, iOS & macOS
- Cloud Engineering, 6+ Years — AWS, Digital Ocean, Terraform, Ansible
- DevOps, 6+ Years — CI pipelines, devcontainers, Kubernetes

Note: Exact data to be provided later.

#### Skills
A grid/collection of specific technologies with an indication of proficiency level (1–3 scale).

Examples:
- Ruby (on Rails): 3/3
- JavaScript/TypeScript: 2/3
- Swift: 3/3
- Go: 2/3
- Docker: 3/3
- Kubernetes: 2/3
- Terraform: 1/3
- GitHub Actions: 2/3
- Lua: 1/3

Note: Complete list to be provided later.

Open question: Should non-engineering skills also be listed here? (e.g. spoken languages, SCRUM/Agile, JIRA)

Idea: Skills displayed as a grid where tile size reflects proficiency level (xs–xl) and related skills are clustered together.

### Career
A chronological list of jobs and positions, ordered from most recent to oldest. Each entry includes the role, company, dates, and a short summary of responsibilities and technologies used.

Examples:
1. Senior Software Engineer @ Kape Technologies [Feb 2022 – Jan 2026]
2. Software Engineer @ Kape Technologies [Feb 2019 – Jan 2022]
3. Junior Software Engineer @ ZenGuard [Aug 2017 – Jan 2019]
4. Software Engineering Intern @ ZenGuard [Feb 2017 – Jul 2017]
5. Software Engineering Intern @ Shopboostr [Jun 2016 – Dec 2016]

Note: Exact descriptions and details to be provided later.

### Projects
A portfolio page listing the projects I've worked on. Each project will have a dedicated detail/show page with more information.

Details TBD.

### Contact
A contact page with links to socials (GitHub, LinkedIn, Slack, Discord, email) and a contact form.

Note: Page label may change (e.g. "Get in touch", "Let's work together").

### Download CV Functionality to download my current CV.

Details TBD (exact flow and user journey to be determined).

---

## Controllers and Routes
All pages are served by a single `PagesController` with one action per page.

```
GET /          → pages#home
GET /home      → pages#home
GET /experience → pages#experience
GET /career    → pages#career
GET /projects  → pages#projects
GET /contact   → pages#contact
```

Download CV route: TBD.

---

## Models
Planned (not yet implemented):
- Expertise
- Skill
- Job

---

## Models, Data and Storage
Planned (not yet implemented):
### Expertise
### Skill
### Job
### Database: not yet added
### Seeding: TBD
### Data generation: TBD

---

## Development Environment
TBD

---

## Deployments and/or CI&CD
TBD
---

## Design Direction
Websites for inspiration:
- https://github.com
- https://docs.digitalocean.com/
- https://lucid.co/
- https://vapor.codes/
- https://signal.org/
- https://thoughtbot.com/

---

## Layout

### Top Navigation

### Footer

### Home
Sites for inspiration:
- https://docs.digitalocean.com/
- https://lucid.co/enterprise

### Experience
Sites for inspiration:
- https://www.ea.com/games/the-sims/the-sims-4/store/categories/stuff-packs (expertise cards)
- https://www.ea.com/games/the-sims/the-sims-4/store (card-per-expertise alternative)

### Career
Vertical stack/timeline, most recent job on top.

### Projects
Standard collection/gallery layout.

### Contact
- Simple contact form
- Links to socials: GitHub, LinkedIn, Slack, Discord, Email

---

## Colors
TBD — to be revisited. Custom palette (not Bulma defaults), dark mode is a must-have.

Previous direction (reverted, may serve as a starting point):
- Blue as primary accent
- Red as secondary accent (sparingly)
- Orange (#F97316) for CTAs
- Light base (white / near-white) for light mode, dark blue-gray for dark mode

---

## Typography
TBD — to be revisited alongside colours.

Previous direction (reverted, may serve as a starting point):
- **Headings / accent text:** Monaspace Neon — https://monaspace.githubnext.com/
- **Body text:** DM Sans — Google Fonts

---

## Content

### Audience
Mainly recruiters and freelancers, perhaps company HR looking for freelancers.

### Tone
- Personal and creative rather than minimal and professional
- Informal over formal
- Laid-back with an occasional cheeky joke
