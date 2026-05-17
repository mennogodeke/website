# Skills
[
  { name: "Ruby on Rails", level: :expert,     icon: "devicon-rails-plain",                       description: "Primary back-end framework — APIs, payment integrations, and full-stack web applications." },
  { name: "Ruby",          level: :expert,     icon: "devicon-ruby-plain",                        description: "The language behind the Rails magic — clean, expressive, and still a joy to write." },
  { name: "Docker",        level: :expert,     icon: "devicon-docker-plain",                      description: "Containerising apps for consistent local development and reliable production deployments." },
  { name: "Git",           level: :expert,     icon: "devicon-git-plain",                         description: "Version control — branches, rebases, and the occasional panic-driven force-push." },
  { name: "GitHub Actions", level: :proficient, icon: "devicon-github-plain",                     description: "CI/CD pipelines for automated testing, linting, and deployment workflows." },
  { name: "PostgreSQL",    level: :proficient, icon: "devicon-postgresql-plain",                  description: "Go-to relational database for production Rails apps — rock solid and well understood." },
  { name: "Go",            level: :proficient, icon: "devicon-go-plain",                          description: "Systems programming and microservices — fast, explicit, and refreshingly boring." },
  { name: "JavaScript",    level: :proficient, icon: "devicon-javascript-plain",                  description: "Front-end scripting alongside back-end Rails projects — from vanilla JS to component-based work." },
  { name: "Kubernetes",    level: :proficient, icon: "devicon-kubernetes-plain",                  description: "Container orchestration for production workloads — deployments, scaling, and the occasional head-scratching YAML." },
  { name: "AWS",           level: :proficient, icon: "devicon-amazonwebservices-plain-wordmark",  description: "Cloud infrastructure — EC2, RDS, SSM, and enough IAM policies to fill a small novel." },
  { name: "TypeScript",    level: :proficient, icon: "devicon-typescript-plain",                  description: "Type-safe JavaScript for larger front-end and Node.js projects." },
  { name: "Node.js",       level: :proficient, icon: "devicon-nodejs-plain",                      description: "Server-side JavaScript for APIs, tooling, and anything that benefits from the npm ecosystem." },
  { name: "Vue.js",        level: :proficient, icon: "devicon-vuejs-plain",                       description: "Component-based front-end framework — the approachable one." },
  { name: "Swift",         level: :proficient, icon: "devicon-swift-plain",                       description: "Native app development for iOS and macOS, plus server-side Swift with the Vapor framework." },
  { name: "Adyen",         level: :proficient, icon: "fa-solid fa-credit-card",                   description: "Payment processing integration — recurring subscriptions, refund handling, and payment method management." },
  { name: "ChargeBee",     level: :proficient, icon: "fa-solid fa-file-invoice-dollar",           description: "Subscription billing platform — product catalog management, campaign automation, and billing lifecycle." },
  { name: "Terraform",     level: :familiar,   icon: "devicon-terraform-plain",                   description: "Infrastructure-as-code for cloud provisioning — because clicking through the AWS console is not a deployment strategy." },
  { name: "Ansible",       level: :familiar,   icon: "devicon-ansible-plain",                     description: "Configuration management and server provisioning — getting machines into a known good state." },
  { name: "Python",        level: :familiar,   icon: "devicon-python-plain",                      description: "Scripting, automation, and the occasional data wrangling task." },
  { name: "Stripe",        level: :familiar,   icon: "devicon-stripe-plain",                      description: "Payment processing integration — checkout flows and subscription management." }
].each do |attrs|
  skill = Skill.find_or_initialize_by(name: attrs[:name])
  skill.assign_attributes(attrs.except(:name))
  skill.save!
end

# Expertises
[
  {
    name: "Back-end Development", years_of_experience: 8,
    icon: "fa-solid fa-server",
    description: "Building APIs, payment integrations, and subscription engines in Ruby on Rails. Eight years of designing systems that handle real money for real users — and haven't caught fire yet.",
    skills: [ "Ruby on Rails", "Ruby", "PostgreSQL", "Docker", "Adyen", "ChargeBee", "Stripe", "Node.js", "TypeScript", "Go" ]
  },
  {
    name: "Full-Stack Development", years_of_experience: 10,
    icon: "fa-solid fa-layer-group",
    description: "Front to back, from database schema to the button that triggers it all. Ten years of making the whole thing work together — including the parts that weren't supposed to talk to each other.",
    skills: [ "Ruby on Rails", "JavaScript", "Vue.js", "TypeScript", "Node.js", "PostgreSQL" ]
  },
  {
    name: "DevOps & Automation", years_of_experience: 5,
    icon: "fa-solid fa-gears",
    description: "Automating everything from local dev environments to production deployments. If something needs to happen more than once, it should happen without me.",
    skills: [ "Docker", "GitHub Actions", "Kubernetes", "Ansible" ]
  },
  {
    name: "Cloud & Infrastructure", years_of_experience: 3,
    icon: "fa-solid fa-cloud",
    description: "Designing and managing cloud infrastructure on AWS — infrastructure-as-code, secrets management, and making sure the database is reachable without opening it to the entire internet.",
    skills: [ "AWS", "Terraform", "Ansible", "Docker", "Kubernetes" ]
  },
  {
    name: "iOS & macOS Development", years_of_experience: 2,
    icon: "fa-brands fa-apple",
    description: "Native app development for Apple platforms using Swift and Xcode, plus server-side Swift with the Vapor framework.",
    skills: [ "Swift" ]
  }
].each do |attrs|
  expertise = Expertise.find_or_initialize_by(name: attrs[:name])
  expertise.assign_attributes(attrs.except(:name, :skills))
  expertise.save!

  attrs[:skills].each do |skill_name|
    skill = Skill.find_by!(name: skill_name)
    ExpertiseSkill.find_or_create_by!(expertise: expertise, skill: skill)
  end
end

# Jobs
[
  {
    title: "Senior Software Engineer", company: "Kape Technologies",
    start_date: "2022-02-01", end_date: "2026-01-01",
    logo: "kape_technologies.png",
    description: "Led payment and subscription engineering across PIA and ExpressVPN. Built an in-house product catalog on top of ChargeBee, automated marketing campaign workflows, and pivoted into DevOps — shipping microservice templates in Go, managing AWS infrastructure with Terraform, and setting up secure database access for developers and CI pipelines via SSM port-forwarding.",
    skills: [ "Ruby on Rails", "Ruby", "Go", "Docker", "AWS", "Terraform", "GitHub Actions", "ChargeBee", "Kubernetes" ]
  },
  {
    title: "Software Engineer", company: "Kape Technologies",
    start_date: "2019-02-01", end_date: "2022-01-01",
    logo: "kape_technologies.png",
    description: "Worked across ZenMate, CyberGhost, and PIA. Led the migration of all paying ZenMate customers to the CyberGhost platform following their merger — a high-stakes data migration with zero room for billing errors. Also built and maintained recurring subscription engines and payment integrations with Adyen, PayPal, and BitPay.",
    skills: [ "Ruby on Rails", "Ruby", "PostgreSQL", "Docker", "JavaScript", "Vue.js", "Adyen" ]
  },
  {
    title: "Junior Software Engineer", company: "ZenGuard",
    start_date: "2017-08-01", end_date: "2019-01-01",
    logo: "zenguard.png",
    description: "Developed and maintained features for the ZenMate VPN product in a Rails and Vue.js stack. Deepened test-driven development practices and got comfortable with the full product development lifecycle — from ticket to production.",
    skills: [ "Ruby on Rails", "Ruby", "Vue.js", "JavaScript", "PostgreSQL" ]
  },
  {
    title: "Software Engineering Intern", company: "ZenGuard",
    start_date: "2017-02-01", end_date: "2017-07-01",
    logo: "zenguard.png",
    description: "First experience with production software engineering — shipping real code for a real product. Learned the fundamentals of TDD, code review, and deploying to production in a professional team environment.",
    skills: [ "Ruby on Rails", "Ruby", "Vue.js", "JavaScript" ]
  },
  {
    title: "Software Engineering Intern", company: "Shopboostr",
    start_date: "2016-06-01", end_date: "2016-12-01",
    logo: "shopboostr.png",
    description: "First steps in professional software development — working in a team, opening pull requests, and contributing to a live Rails application. Shopboostr was a small software agency taking on varied client projects.",
    skills: [ "Ruby on Rails", "JavaScript" ]
  }
].each do |attrs|
  job = Job.find_or_initialize_by(title: attrs[:title], company: attrs[:company])
  job.assign_attributes(attrs.except(:title, :company, :skills))
  job.save!

  attrs[:skills].each do |skill_name|
    skill = Skill.find_by!(name: skill_name)
    JobSkill.find_or_create_by!(job: job, skill: skill)
  end
end

# Projects
[
  {
    name: "menno.codes", position: 1, year: 2026,
    url: nil, repo_url: "https://github.com/mennogodeke/website",
    description: "This very website — a personal portfolio and CV built with Rails 8. Features a CV download flow with email-gated token links, PDF generation, and a Kamal deployment pipeline.",
    skills: [ "Ruby on Rails", "Ruby", "PostgreSQL", "Docker" ]
  },
  {
    name: "Timelanes", position: 2, year: 2026,
    url: nil, repo_url: nil,
    description: "A side project in two flavours — the same app written in both Ruby on Rails and Swift (Vapor). The goal: a playground for Kubernetes experiments, A/B traffic splitting, and benchmarking real-world performance differences between the two stacks.",
    skills: [ "Ruby on Rails", "Swift", "Kubernetes", "Docker" ]
  },
  {
    name: "we-voucher.de", position: 3, year: 2021,
    url: nil, repo_url: nil,
    description: "A voucher campaign platform built for Incent-Now — developed the API handling voucher claims and an admin dashboard for campaign configuration, code generation, and reporting. Ran campaigns in partnership with Thalia and Eurowings. The company was liquidated in 2022.",
    skills: [ "Ruby on Rails", "Ruby", "PostgreSQL", "JavaScript" ]
  },
  {
    name: "Pool Bar Website", position: 4, year: 2025,
    url: nil, repo_url: nil,
    description: "A WordPress website for a local pool bar — custom theme, contact form, and event listings.",
    skills: []
  }
].each do |attrs|
  project = Project.find_or_initialize_by(name: attrs[:name])
  project.assign_attributes(attrs.except(:name, :skills))
  project.save!

  attrs[:skills].each do |skill_name|
    skill = Skill.find_by!(name: skill_name)
    ProjectSkill.find_or_create_by!(project: project, skill: skill)
  end
end
