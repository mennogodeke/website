/* ============================================================
   Fake content for the UI kit — modelled on website/CONTENT_DATA.yml
   Trimmed to the essentials the kit demonstrates.
   ============================================================ */

// Tech skills. Mirrors entries from CONTENT_DATA.yml.
window.skills = [
  { key:'ruby_on_rails', name:'Ruby on Rails', level:'expert',     accent:'#CC0000', icon:'devicon-rails-plain',                       desc:'Primary back-end framework — APIs, payment integrations, and full-stack web applications.' },
  { key:'ruby',          name:'Ruby',          level:'expert',     accent:'#CC342D', icon:'devicon-ruby-plain',                        desc:'The language behind the Rails magic — clean, expressive, and still a joy to write.' },
  { key:'docker',        name:'Docker',        level:'expert',     accent:'#2496ED', icon:'devicon-docker-plain',                      desc:'Containerising apps for consistent local development and reliable production deployments.' },
  { key:'git',           name:'Git',           level:'expert',     accent:'#F05032', icon:'devicon-git-plain',                         desc:'Version control — branches, rebases, and the occasional panic-driven force-push.' },
  { key:'github_actions',name:'GitHub Actions',level:'proficient', accent:'#2088FF', icon:'devicon-github-plain',                      desc:'CI/CD pipelines for automated testing, linting, and deployment workflows.' },
  { key:'postgresql',    name:'PostgreSQL',    level:'proficient', accent:'#336791', icon:'devicon-postgresql-plain',                  desc:'Go-to relational database for production Rails apps — rock solid and well understood.' },
  { key:'go',            name:'Go',            level:'proficient', accent:'#00ADD8', icon:'devicon-go-plain',                          desc:'Systems programming and microservices — fast, explicit, and refreshingly boring.' },
  { key:'javascript',    name:'JavaScript',    level:'proficient', accent:'#F7DF1E', icon:'devicon-javascript-plain',                  desc:'Front-end scripting alongside back-end Rails projects — from vanilla JS to component-based work.' },
  { key:'kubernetes',    name:'Kubernetes',    level:'proficient', accent:'#326CE5', icon:'devicon-kubernetes-plain',                  desc:'Container orchestration for production workloads — deployments, scaling, and the odd YAML.' },
  { key:'aws',           name:'AWS',           level:'proficient', accent:'#FF9900', icon:'devicon-amazonwebservices-plain-wordmark',  desc:'Cloud infrastructure — EC2, RDS, SSM, and enough IAM policies to fill a small novel.' },
  { key:'typescript',    name:'TypeScript',    level:'proficient', accent:'#3178C6', icon:'devicon-typescript-plain',                  desc:'Type-safe JavaScript for larger front-end and Node.js projects.' },
  { key:'nodejs',        name:'Node.js',       level:'proficient', accent:'#339933', icon:'devicon-nodejs-plain',                      desc:'Server-side JavaScript for APIs, tooling, and anything that benefits from the npm ecosystem.' },
  { key:'vuejs',         name:'Vue.js',        level:'proficient', accent:'#42B883', icon:'devicon-vuejs-plain',                       desc:'Component-based front-end framework — the approachable one.' },
  { key:'swift',         name:'Swift',         level:'proficient', accent:'#F05138', icon:'devicon-swift-plain',                       desc:'Native app development for iOS and macOS, plus server-side Swift with Vapor.' },
  { key:'terraform',     name:'Terraform',     level:'familiar',   accent:'#844FBA', icon:'devicon-terraform-plain',                   desc:'Infrastructure-as-code for cloud provisioning — clicking through the AWS console is not a plan.' },
  { key:'ansible',       name:'Ansible',       level:'familiar',   accent:'#EE0000', icon:'devicon-ansible-plain',                     desc:'Configuration management and server provisioning — getting machines into a known good state.' },
  { key:'python',        name:'Python',        level:'familiar',   accent:'#3776AB', icon:'devicon-python-plain',                      desc:'Scripting, automation, and the occasional data wrangling task.' },
  { key:'stripe',        name:'Stripe',        level:'familiar',   accent:'#635BFF', icon:'devicon-stripe-plain',                      desc:'Payment processing integration — checkout flows and subscription management.' },
];
window.skillByKey = Object.fromEntries(window.skills.map(s => [s.key, s]));

// Experience areas (Experience page). Each "panel" is one of these.
window.experiences = [
  { key:'backend',       name:'Back-end Development',   years:8,  accent:'legendary', icon:'fa-solid fa-server',     skillKeys:['ruby_on_rails','ruby','postgresql','docker','go','nodejs','typescript'],
    desc:`Building APIs, payment integrations, and subscription engines in Ruby on Rails. Eight years of designing systems that handle real money for real users — and haven't caught fire yet.` },
  { key:'fullstack',     name:'Full-Stack Development', years:10, accent:'legendary', icon:'fa-solid fa-layer-group',skillKeys:['ruby_on_rails','javascript','vuejs','typescript','nodejs','postgresql'],
    desc:`Front to back, from database schema to the button that triggers it all. Ten years of making the whole thing work together — including the parts that weren't supposed to talk to each other.` },
  { key:'devops',        name:'DevOps & Automation',    years:5,  accent:'epic',      icon:'fa-solid fa-gears',      skillKeys:['docker','github_actions','kubernetes','ansible'],
    desc:`Automating everything from local dev environments to production deployments. If something needs to happen more than once, it should happen without me.` },
  { key:'cloud',         name:'Cloud & Infrastructure', years:3,  accent:'rare',      icon:'fa-solid fa-cloud',      skillKeys:['aws','terraform','ansible','docker','kubernetes'],
    desc:`Designing and managing cloud infrastructure on AWS — infrastructure-as-code, secrets management, and making sure the database is reachable without opening it to the entire internet.` },
  { key:'microservices', name:'Microservices',          years:3,  accent:'rare',      icon:'fa-solid fa-cubes',      skillKeys:['go','typescript','nodejs','kubernetes','terraform','github_actions'],
    desc:`Three years designing and operating distributed systems — decomposing monoliths into services, wiring them together with Kubernetes and Terraform.` },
  { key:'apps',          name:'iOS & macOS',            years:2,  accent:'uncommon',  icon:'fa-brands fa-apple',     skillKeys:['swift'],
    desc:`Native app development for Apple platforms using Swift and Xcode, plus server-side Swift with the Vapor framework.` },
];

// Career jobs (Career page).
window.jobs = [
  { key:'kape_senior',     title:'Senior Software Engineer',     company:'Kape Technologies', start:2022, end:2026, initials:'KT',
    desc:`Led payment and subscription engineering across PIA and ExpressVPN. Built an in-house product catalog on top of ChargeBee, automated marketing campaign workflows, and pivoted into DevOps — shipping microservice templates in Go, managing AWS infrastructure with Terraform, and setting up secure database access via SSM port-forwarding.`,
    skillKeys:['ruby_on_rails','ruby','go','docker','aws','terraform','github_actions','kubernetes'] },
  { key:'kape_mid',        title:'Software Engineer',            company:'Kape Technologies', start:2019, end:2022, initials:'KT',
    desc:`Worked across ZenMate, CyberGhost, and PIA. Led the migration of all paying ZenMate customers to the CyberGhost platform following their merger — a high-stakes data migration with zero room for billing errors. Also built and maintained recurring subscription engines and payment integrations with Adyen, PayPal, and BitPay.`,
    skillKeys:['ruby_on_rails','ruby','postgresql','docker','javascript','vuejs'] },
  { key:'zenguard_junior', title:'Junior Software Engineer',     company:'ZenGuard',          start:2017, end:2019, initials:'ZG',
    desc:`Developed and maintained features for the ZenMate VPN product in a Rails and Vue.js stack. Deepened test-driven development practices and got comfortable with the full product development lifecycle — from ticket to production.`,
    skillKeys:['ruby_on_rails','ruby','vuejs','javascript','postgresql'] },
  { key:'zenguard_intern', title:'Software Engineering Intern',  company:'ZenGuard',          start:2017, end:2017, initials:'ZG',
    desc:`First experience with production software engineering — shipping real code for a real product. Learned the fundamentals of TDD, code review, and deploying to production in a professional team environment.`,
    skillKeys:['ruby_on_rails','ruby','vuejs','javascript'] },
  { key:'shopboostr',      title:'Software Engineering Intern',  company:'Shopboostr',        start:2016, end:2016, initials:'SB',
    desc:`First professional engineering experience — building features for an e-commerce platform in Berlin.`,
    skillKeys:['ruby_on_rails','ruby','javascript'] },
];

// Projects (Projects page).
window.projects = [
  { key:'menno_codes', name:'menno.codes', year:2026,
    desc:`This portfolio — a Rails 8 site with a custom CSS design system, three languages, and an email-gated CV download flow. Built to demonstrate, not just describe.`,
    skillKeys:['ruby_on_rails','postgresql','docker','javascript'] },
  { key:'payment_engine', name:'Subscription Engine', year:2023,
    desc:`In-house product catalog and billing system layered on top of ChargeBee. Handles plan upgrades, refunds, dunning, and the dozen edge cases that nobody mentions in the original spec.`,
    skillKeys:['ruby_on_rails','postgresql','aws','terraform'] },
  { key:'vpn_migration', name:'ZenMate → CyberGhost Migration', year:2021,
    desc:`Migrated every paying ZenMate customer to the CyberGhost billing platform after the company merger. A few hundred thousand subscriptions, three payment providers, and exactly zero tolerance for double-billing.`,
    skillKeys:['ruby_on_rails','postgresql','docker','javascript'] },
  { key:'go_microservices', name:'Go microservice templates', year:2024,
    desc:`A reusable scaffold for spinning up new Go microservices at Kape — pre-wired with structured logging, health checks, Kubernetes manifests, and a CI pipeline that yells at you about the right things.`,
    skillKeys:['go','docker','kubernetes','terraform','github_actions'] },
];

// Floating chip positions for the home hero.
window.chipPositions = [
  ['5%','12%'],['88%','8%'],['72%','72%'],['18%','82%'],
  ['92%','38%'],['3%','55%'],['55%','88%'],['80%','22%'],
  ['40%','5%'],['65%','55%'],['25%','35%'],['10%','68%'],
  ['48%','78%'],['82%','88%'],['32%','18%'],['92%','62%'],
];
