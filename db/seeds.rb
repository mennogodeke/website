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
Job.find_or_create_by!(title: "Senior Software Engineer", company: "Kape Technologies") do |job|
  job.start_date = "2022-02-01"
  job.end_date   = "2026-01-01"
  job.description = "Led development of payment integrations and data-heavy Rails applications. Focused on TDD and CI/CD pipelines."
end

Job.find_or_create_by!(title: "Software Engineer", company: "Kape Technologies") do |job|
  job.start_date = "2019-02-01"
  job.end_date   = "2022-01-01"
  job.description = "Built and maintained APIs and back-end services for a suite of privacy-focused products."
end

Job.find_or_create_by!(title: "Junior Software Engineer", company: "ZenGuard") do |job|
  job.start_date = "2017-08-01"
  job.end_date   = "2019-01-01"
end

Job.find_or_create_by!(title: "Software Engineering Intern", company: "ZenGuard") do |job|
  job.start_date = "2017-02-01"
  job.end_date   = "2017-07-01"
end

Job.find_or_create_by!(title: "Software Engineering Intern", company: "Shopboostr") do |job|
  job.start_date = "2016-06-01"
  job.end_date   = "2016-12-01"
end
