# Skills
[
  { name: "Ruby on Rails", level: :expert,     description: "Primary back-end framework — APIs, payment integrations, full-stack apps." },
  { name: "Ruby",          level: :expert,     description: nil },
  { name: "Swift",         level: :expert,     description: "Native app development for iOS and macOS." },
  { name: "Docker",        level: :expert,     description: "Containerising apps for local dev and production deployments." },
  { name: "Git",           level: :expert,     description: nil },
  { name: "GitHub Actions", level: :proficient, description: "CI/CD pipelines for automated testing and deployment." },
  { name: "PostgreSQL",    level: :proficient, description: nil },
  { name: "Go",            level: :proficient, description: nil },
  { name: "JavaScript",    level: :proficient, description: "Front-end scripting, component-based work alongside back-end projects." },
  { name: "Kubernetes",    level: :proficient, description: "Container orchestration for production workloads." },
  { name: "AWS",           level: :proficient, description: nil },
  { name: "Terraform",     level: :familiar,   description: "Infrastructure-as-code for cloud provisioning." },
  { name: "Lua",           level: :familiar,   description: nil },
  { name: "Python",        level: :familiar,   description: nil },
  { name: "Ansible",       level: :familiar,   description: nil }
].each do |attrs|
  Skill.find_or_create_by!(name: attrs[:name]) do |skill|
    skill.level       = attrs[:level]
    skill.description = attrs[:description]
  end
end

# Expertises
[
  {
    name: "Back-end Development", years_of_experience: 8,
    description: "Building APIs, payment integrations, and data-heavy Rails applications. Strong focus on TDD and CI/CD pipelines.",
    skills: [ "Ruby on Rails", "Ruby", "PostgreSQL", "Docker" ]
  },
  {
    name: "Cloud Engineering", years_of_experience: 6,
    description: "Designing and managing cloud infrastructure across AWS and DigitalOcean, with a focus on infrastructure-as-code and reliability.",
    skills: [ "AWS", "Terraform", "Ansible", "Docker" ]
  },
  {
    name: "DevOps", years_of_experience: 6,
    description: "Automating everything from local dev environments to production deployments. If I have to do it twice, I automate it.",
    skills: [ "Docker", "GitHub Actions", "Kubernetes" ]
  },
  {
    name: "iOS & macOS Development", years_of_experience: 4,
    description: "Native app development for Apple platforms — from side projects to production apps on the App Store.",
    skills: [ "Swift" ]
  },
  {
    name: "Front-end Development", years_of_experience: 3,
    description: "Building interfaces that don't make users want to close the tab. Mostly component-based work alongside back-end projects.",
    skills: [ "JavaScript" ]
  }
].each do |attrs|
  expertise = Expertise.find_or_create_by!(name: attrs[:name]) do |e|
    e.years_of_experience = attrs[:years_of_experience]
    e.description         = attrs[:description]
  end

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
    description: "Led development of payment integrations and data-heavy Rails applications. Focused on TDD and CI/CD pipelines.",
    skills: [ "Ruby on Rails", "Ruby", "PostgreSQL", "Docker", "AWS", "GitHub Actions" ]
  },
  {
    title: "Software Engineer", company: "Kape Technologies",
    start_date: "2019-02-01", end_date: "2022-01-01",
    description: "Built and maintained APIs and back-end services for a suite of privacy-focused products.",
    skills: [ "Ruby on Rails", "Ruby", "PostgreSQL", "Docker" ]
  },
  {
    title: "Junior Software Engineer", company: "ZenGuard",
    start_date: "2017-08-01", end_date: "2019-01-01",
    description: nil,
    skills: [ "Ruby on Rails", "Ruby" ]
  },
  {
    title: "Software Engineering Intern", company: "ZenGuard",
    start_date: "2017-02-01", end_date: "2017-07-01",
    description: nil,
    skills: [ "Ruby on Rails", "Ruby" ]
  },
  {
    title: "Software Engineering Intern", company: "Shopboostr",
    start_date: "2016-06-01", end_date: "2016-12-01",
    description: nil,
    skills: [ "Ruby on Rails", "JavaScript" ]
  }
].each do |attrs|
  job = Job.find_or_create_by!(title: attrs[:title], company: attrs[:company]) do |j|
    j.start_date  = attrs[:start_date]
    j.end_date    = attrs[:end_date]
    j.description = attrs[:description]
  end

  attrs[:skills].each do |skill_name|
    skill = Skill.find_by!(name: skill_name)
    JobSkill.find_or_create_by!(job: job, skill: skill)
  end
end

# Projects
[
  {
    name: "menno.codes",
    description: "This very website — a personal portfolio and CV built with Rails 8. Features a CV download flow with email-gated token links and PDF generation via Grover.",
    url: nil,
    repo_url: "https://github.com/mennogodeke/website",
    year: 2026,
    position: 1,
    skills: [ "Ruby on Rails", "Ruby", "PostgreSQL", "Docker" ]
  },
  {
    name: "Project Placeholder",
    description: "A placeholder project. Replace this with something real once you have more projects to show.",
    url: nil,
    repo_url: nil,
    year: nil,
    position: 2,
    skills: []
  },
  {
    name: "Another Placeholder",
    description: "Another placeholder project. Replace this with something real once you have more projects to show.",
    url: nil,
    repo_url: nil,
    year: nil,
    position: 3,
    skills: []
  }
].each do |attrs|
  project = Project.find_or_create_by!(name: attrs[:name]) do |p|
    p.description = attrs[:description]
    p.url         = attrs[:url]
    p.repo_url    = attrs[:repo_url]
    p.year        = attrs[:year]
    p.position    = attrs[:position]
  end

  attrs[:skills].each do |skill_name|
    skill = Skill.find_by!(name: skill_name)
    ProjectSkill.find_or_create_by!(project: project, skill: skill)
  end
end
