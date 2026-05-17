# Content

## Audience
Both recruiters screening for permanent roles and freelance clients looking to hire directly.
Preference is toward permanent employment, but open to both. No specific industry focus.

## Tone
Personal and human rather than corporate. Informal but competent — the kind of person you'd
want to work with, not just hire. Occasional dry humour is fine; never forced.
Icon library: Devicons (tech stack) + Font Awesome (categories/UI).
(Further tone refinement TBD — revisit once first page copy is drafted.)

# About Me
## Full-Stack Web, App & Platform Developer

## Details
Name: Menno Godeke
DoB: 28-05-1994
Nationality: Dutch
Location: Osnabruck, Germany

## Languages
Dutch - Native
English - Fluent
German - Fluent

## Work Experience
- 10+ years of experience [breakdown](#breakdown)
- Focussed heavily on Backend development, DevOps & Automation and Cloud Infrastructure
- Worked for small startups as well as big coorporate 
- Majority of companies where in the Security and Privacy business. (ZenMate, CyberGhost, Private Internet Access and ExpressVPN)
- Majority of work was related to payments and recurring subscriptions management. (Stripe, Adyen, ChargeBee)

## Jobs
1. Senior Software Engineer @ Kape Technologies [Feb 2022 – Jan 2026]
2. Software Engineer @ Kape Technologies [Feb 2019 – Jan 2022]
3. Junior Software Engineer @ ZenGuard [Aug 2017 – Jan 2019]
4. Software Engineering Intern @ ZenGuard [Feb 2017 – Jul 2017]
5. Software Engineering Intern @ Shopboostr [Jun 2016 – Dec 2016]

### Expertise and Skills Breakdown

#### Backend: 8+ Years
APIs
Microservices
Payment Processing
Ruby and Rails
GoLang
Typescript
Node.js
TDD

#### Fullstack: 6+ Years
Ruby on Rails
JavaScript
Vue.js
Bootstrap
Bulma CSS
Tailwind CSS
Swift On the web (Vapor)
TDD

#### DevOps & Automation: 5+ Years
Docker
DevContainers
Kubernetes
Helm
GitHub Actions (CI/CD)
3rd party integrations (Slack, Jira, etc)
sqlite3


#### Cloud & Infrastructure: 3+ Years
Linux
Terraform
Ansible
AWS
Digital Ocean
Databases (Postgres, MySQL)
Secrets Management
Monitoring (Grafana)

#### Apps: 2 Years
macOS 
iOS
Swift
XCode

---

# Interview

## Audience & Tone

**A1.** Who is the primary person landing on this site? Pick the most accurate description:
- a) Freelance clients who found me via referral or LinkedIn and want to hire me directly
- b) Recruiters screening me for a permanent role
- c) Both in roughly equal measure
- d) Something else
**Answer:** C - Both Freelance clients and Recruiters

**A2.** Are you currently open to permanent roles, freelance only, or both? This shapes how the site should pitch you.
**Answer:** Im open to both, but would prefer a permanent role

**A3.** Any industries or types of companies you specifically want to attract (or avoid)? E.g. more VPN/privacy companies, fintech, startups, etc.
**Answer:** No preference

**A4.** For tone: the old notes said "laid-back with an occasional cheeky joke." Is that still right, or has your thinking shifted? Any references — a site, a person's writing style, a vibe — that feel closer to what you're after?
**Answer:** Not sure about this yet

---

## Jobs

**J1.** Kape Technologies acquired several VPN brands (ZenMate, CyberGhost, PIA, ExpressVPN). Which products were you actually working on day-to-day, and did that change between your Junior and Senior stints?
**Answer:** I worked on all 4 VPN brands. Yes it changed between junior and senior stints:
- Software Engineering Intern: ZenMate
- Junior Software Engineer: ZenMate
- Software Engineer: ZenMate, CyberGhost, PIA
- Senior Software Engineer: PIA, ExpressVPN

**J2.** You mentioned payments and subscriptions as a major focus. What did that look like in practice? (e.g. migrating payment providers, building subscription engines, handling dunning/retries, fraud, etc.)
**Answer:**
- ZenMate: Developing and Maintaining In-house recurring subscription engine (ruby on rails). Developing and maintaining payment integrations: Adyen and PayPal
- ZenMate/CyberGhost: After the ZenMate<->CyberGhost M&A I was responsible for migrating all of ZenMate's paying customers to CyberGhost platform. This was done mainly through a dedicated migration endpoint that was called by the CyberGhost mobile apps and online dashboard.
- PIA: Developing and Maintaining In-house recurring subscription engine (ruby on rails). Developing and maintaining payment integrations: Adyen, PayPal and BitPay
- ExpressVPN: 
A. Developing and Maintaining in-house product catalog built on-top of ChargeBee in order to provide data and functionality not supported by ChargeBeee at the time. 
B. Implemented automated process for the marketing department where they could fill in a form with campaign data (eg pricing data, campaign runtime etc.) that would then be processed and stored in the DB.
C. Shifted focus to DevOps, Cloud Infrastructure and Automation. Developed universal templates for developers so they can quickly create new microservices written in GoLang and using [cruft](https://github.com/cruft/cruft). Also developed and maintained platform infrastructure on AWS using Terraform.

**J3.** Senior role: what's the one project or accomplishment from those 4 years you're most proud of? Something concrete you could describe in 2–3 sentences.
**Answer:** Setup an automated and secure way to connect to the database using [portwarding and SSM tunnels](https://aws.amazon.com/blogs/mt/use-port-forwarding-in-aws-systems-manager-session-manager-to-connect-to-remote-hosts/) used for developers to debug and CI pipelines to run DB migrations.

**J4.** Junior role at Kape: was this mostly ramping up on the same codebase, or did you own different areas? Any specific responsibilities or projects worth calling out?
**Answer:** I wasn't a Junior Dev when Kape became involved. I was a regular software engineer after the M&A. See J2: ZenMate/Cyberghost answer. (Responsible for migrating paying ZenMate customers) for specific responsibilities worth calling out.  

**J5.** ZenGuard — is this the same entity as ZenMate, or a separate company? What was your main stack and what were you building there (consumer product, internal tooling, infrastructure)?
**Answer:** It's the same company. The company name was ZenGuard, the VPN app was called ZenMate. 
What i did during that time: Getting familiar with TDD, Project Management Processes, and deploying production ready applications. Stack was Ruby on Rails with a Vue.js Front-end.

**J6.** Shopboostr — what did this company do, and what did your internship actually involve? It's a blank in the current seeds so even a short description helps.
**Answer:** Gaining my first experiences working as a professional software engineer working in a team. Opened and merged my first PR's for a online parking app(no longer exists, stack was ruby on rails)
The company itself was a small software engineering start-up picking up all sorts of software engineering, see: https://www.shopboostr.de/

**J7.** Are there any contract/freelance gigs between or alongside these jobs that are worth listing?
**Answer:** No not yet

---

## Projects

**P1.** Besides this portfolio site, do you have any public or notable projects — open source, side projects, things you shipped at work that you can talk about publicly?
**Answer:** Yes I did 1 public project for a company that no longer exists (liquidated 03/2022). The company was called Incent-Now. They had a website: www.we-voucher.de where customers could participate in raffle like campaigns. Visitors would have acquired a voucher code through a variaty of channels. Examples include a co-op with thalia where customers would buy a book and get a folder with a collection of voucher codes. And another co-op with Eurowings where a similair folder with a collection of voucher codes was handed out to all passengers.
I was responsible for developing the API that handled the voucher claims. Besides that i also developed a backend dashboard where voucher campaigns could be configured, voucher codes be generated and providing previous campaign data. Stack we used was: Ruby on Rails backend, a custom wordpress plugin on the front-end

Besides that there are 2 more projects about to go live. 
First project is a personal pet project which are basically 2 "identical" web apps. One written in Ruby on Rails the other in Swift using the Vapor framework. This project is mainly for me to practice and experiment with Kubernetes, Doing A/B tests and simulating high traffic loads to then profile/benchmark code performance
Second project is a basic Wordpress website for a Pool bar. 

**P2.** Any iOS/macOS apps on the App Store (even if removed)? You have Swift listed as expert-level so I'd expect something here.
**Answer:** No i don't. The "expert" level is not accurate, it should be one level lower

**P2b.** The pet project (Rails + Vapor benchmarking app) — does it have a name yet? And is the repo public or private? Even if it's not live yet I can list it as "in progress."
**Answer:** You can call it "Timelanes" for now.

**P3.** Any tools, scripts, or libraries you've built and put on GitHub that you're happy to show?
**Answer:** No not yet

**P3b.** The pool bar WordPress site — worth listing as a project, or too basic to feature?
**Answer:** Lets list it for now

**P4.** Are you OK with the portfolio site (menno.codes) being listed as project #1, or would you rather lead with something else?
**Answer:** Yes its fine to use this site as the first example

---

## Skills & Expertises

**S1.** The current seeds list Lua as "familiar" — where did that come from? (OpenResty/nginx scripting, game modding, something else?)
**Answer:** I just got started with Lua, mainly to try out neovim and it's customization capabilities. 

**S2.** TypeScript and Node.js appear in your breakdown but aren't in the seeds as separate skills. Should they be, and at what level?
**Answer:** Yes they should, they should be listed as "proficient"

**S3.** Vue.js is in the breakdown but missing from seeds. Add it? What level — proficient or familiar?
**Answer:** Yes add it - Proficient

**S4.** ChargeBee, Stripe, Adyen are mentioned as major focus areas. Should payment platforms be listed as skills, or is that covered under expertise descriptions?
**Answer:** Not sure, what do you think?

**S5.** The "Fullstack" expertise in seeds is listed as 6 years but your breakdown says the same. The "Apps" expertise says 4 years in seeds but 2 years in your breakdown — which is correct?
**Answer:** Fullstack should be 10 years. Apps should be 2 years.

**S6.** Any skill you feel is underrepresented or missing entirely from the current list?
**Answer:** Not yet, will revisit later

**S7.** Payment platforms — my recommendation is to list Adyen, ChargeBee and Stripe as separate skills since they're a significant and specialised part of your background (not every Rails dev has deep payment processor experience). Suggested levels: Adyen → proficient, ChargeBee → proficient, Stripe → familiar. Does that sound right, or would you adjust? 
**Answer:** Yes thats sounds good.

**S8.** Lua — given it's purely for Neovim config rather than professional work, I'd lean toward dropping it from the skills list entirely. It doesn't reflect something a recruiter or client cares about. Agree, or keep it?
**Answer:** Ok lets leave it out for now.

---

## Visual / Branding

**V1.** For accent colours per job/expertise/skill — do you have preferences, or should I suggest colours based on company brand colours (e.g. Kape's blue, etc.)?
**Answer:** Lets hold off on this for now

**V2.** For icons: are you using a specific icon library (Devicons, Simple Icons, Font Awesome, Lucide)? Or is this still TBD?
**Answer:** I was planning on using Font Awesome, but im open to change that. What do you recommend? 
**Follow-up:** My recommendation is a hybrid: **Devicons** for programming languages and frameworks (Ruby, Go, Docker, Kubernetes etc — they have proper branded icons for all of these) and **Font Awesome** for everything else (expertise categories, UI elements, contact icons). Devicons is purpose-built for tech stacks and looks much sharper than FA's generic code icon. Agree?
**Answer:** Agree

**V3.** Do you have company logos for each employer, or will those need to be sourced?
**Answer:** I'll provide them. Added to /app/assets/images