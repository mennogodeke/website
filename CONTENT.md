# Content

## Audience
Mainly recruiters and freelancers, perhaps company HR looking for freelancers.

## Tone
- Personal and creative rather than minimal and professional
- Informal over formal
- Laid-back with an occasional cheeky joke

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
