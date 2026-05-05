# Personal Website
My personal portfolio / CV website to showcase the skills and knowledge i've gained over the years, the jobs i've had and the projects i've built. Additionally there should be the option to download my CV.

## Stack
- Ruby On Rails 8.1.3
- ruby-3.4.7
- Bulma.css
- TBD: Database

## Navigation
No dropdowns. Flat navigation bar with the following items:

```
[home, experience, career, projects, contact, download cv]
```

Note: The label "contact" is not set in stone — alternatives like "Get in touch" or "Let's work together" are on the table. The order of "contact" and "download cv" is also still open.

---

## Pages

### Home
The landing page, also serving as the traditional "About" page.

- Big title/hero (e.g. "Freelance Software Engineer" or "Web & App Development") might include something with my name
- Professional headshot / placeholder image
- Short personal introduction / bio
- CTAs and hints pointing visitors to other sections of the site

---

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

Note: Exact data on experience to be provided later.

#### Skills
A grid/collection of specific technologies with an indication of proficiency level (e.g. 1–5 scale).

Examples:
- Ruby (on Rails): 5/5
- JavaScript/TypeScript: 2/5
- Swift: 4/5
- Go: 3/5
- Docker: 5/5
- Kubernetes: 3/5
- Terraform: 3/5
- GitHub Actions: 4/5
- Lua: 2/5

Note: Complete list to be provided later.

Open question: Should non-engineering skills also be listed here? (e.g. spoken languages, SCRUM/Agile, JIRA)

---

### Career
A chronological list of jobs and positions, ordered from most recent to oldest. Each entry includes the role, company, dates, and a short summary of responsibilities and technologies used.

Examples:
1. Senior Software Engineer @ Kape Technologies [Feb 2022 – Jan 2026]
2. Software Engineer @ Kape Technologies [Feb 2019 – Jan 2022]
3. Junior Software Engineer @ ZenGuard [Aug 2017 – Jan 2019]
4. Software Engineering Intern @ ZenGuard [Feb 2017 – Jul 2017]
5. Software Engineering Intern @ Shopboostr [Jun 2016 – Dec 2016]

Note: Exact descriptions and details to be provided later.

---

### Projects
A portfolio page listing the projects I've worked on. Each project will have a dedicated detail/show page with more information.

Details TBD.

---

### Contact
A contact page with links to socials (GitHub, Slack, Discord, email) and a contact form.

Note: Page label may change (e.g. "Get in touch", "Let's work together").

---

### Download CV
Functionality to download my current CV.

Details TBD (exact flow and user journey to be determined).

---

## Models
- Expertise
- Skill
- Job

## Controllers and Routes
- Static Pages
- Experience
- Jobs
- Projects

## Data and Storage
- Database
- Seeding Data
- Generating Data

## Development Environment
TBD

## Deployments and/or CI&CD
TBD

## Design Direction
Websites for inspiration:
- https://github.com 
- https://docs.digitalocean.com/
- https://lucid.co/
- https://vapor.codes/
- https://signal.org/
- https://thoughtbot.com/


## Layout

### Top Navigation

### Footer

### Home
Sites for inspiration:
- https://docs.digitalocean.com/
- https://lucid.co/enterprise

Notes:
- Big title/hero (e.g. "Freelance Software Engineer" or "Web & App Development") might include something with my name
- Professional headshot / placeholder image
- Short personal introduction / bio
- CTAs and hints pointing visitors to other sections of the site

### Experience
- https://www.ea.com/games/the-sims/the-sims-4/store/categories/stuff-packs Could be used as insipiration for "Expertises" With below it a collection of related Skills OR perhaps: https://www.ea.com/games/the-sims/the-sims-4/store simply having a card for every expertise

Idea: I have this idea of putting all the skills together into one big grid. This would be it's own section below the Expertises (Or perhaps a dedicated page). The size of the tiles would be determined by the "level/amount of experience" eg xs, s, m, l or xl. and the position would be determined by skills that are "related" to each other. Eg the Skills: Ruby, Ruby on Rails and Rspec should all be close together. Any thoughts/feedback on this?

### Career
Should be some sort of vertical stack/list with the most recent job listed on top.

### Projects
A standard collection/gallery kind of page.

### Contact
- Should include a simple contact for
- links to socials: GitHub, LinkedIn, Slack, Discord, Email

## Colors
Custom color palette (not Bulma defaults). Dark mode is a must-have.

### Blue — primary accent
| Token | Hex | Usage |
|---|---|---|
| blue-50 | #EFF6FF | Background tint |
| blue-200 | #BFDBFE | Subtle borders |
| blue-400 | #60A5FA | Light actions |
| blue-600 | #2563EB | Primary action |
| blue-700 | #1D4ED8 | Hover / active state |
| blue-900 | #1E3A8A | Heading text |

### Red — secondary accent (sparingly)
| Token | Hex | Usage |
|---|---|---|
| red-100 | #FEE2E2 | Background tint |
| red-500 | #EF4444 | Accent |
| red-700 | #B91C1C | Hover |

Use red for highlights and badges only — not buttons or large fills.

### Orange — CTA
| Token | Hex | Usage |
|---|---|---|
| orange-500 | #F97316 | CTA buttons and standout interactions |

### Neutrals
| Token | Hex | Light mode | Dark mode |
|---|---|---|---|
| neutral-bg | #FFFFFF / #0F172A | Background | Background |
| neutral-surface | #F8FAFC / #1E293B | Cards / surfaces | Cards / surfaces |
| neutral-text | #1E293B / #F1F5F9 | Body text | Body text |

## Typography
- **Headings / accent text: Monaspace** (https://monaspace.githubnext.com/) — available via GitHub Next CDN
- **Body text: DM Sans** — available via Google Fonts
- Inspiration: RubyGems, https://docs.digitalocean.com/



## Content
### Audience
Mainly Recruiters and other freelancers, perhaps compant HR looking for freelancers.

### Tone
- Should be more personal and creative rather then minimal and professional. 
- More leaning towards informal communication vs formal.
- Laid-back with an occasional cheeky joke

