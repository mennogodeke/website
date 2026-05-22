require "yaml"

data = YAML.load_file(Rails.root.join("CONTENT_DATA.yml"))

# Build a lookup map: skill key → skill record (populated after Skills seeding)
skill_index = {}

# Skills
data["skills"].each do |attrs|
  en = attrs["translations"]["en"]
  nl = attrs["translations"]["nl"]
  de = attrs["translations"]["de"]

  skill = Skill.find_or_initialize_by(name: en["name"])
  skill.assign_attributes(
    level:           attrs["level"],
    icon:            attrs["icon"],
    accent:          attrs["accent"],
    description_en:  en["description"],
    description_nl:  nl["description"],
    description_de:  de["description"]
  )
  skill.save!
  skill_index[attrs["key"]] = skill
end

# Experiences
data["experiences"].each do |attrs|
  en = attrs["translations"]["en"]
  nl = attrs["translations"]["nl"]
  de = attrs["translations"]["de"]

  experience = Experience.find_or_initialize_by(name: en["name"])
  experience.assign_attributes(
    years_of_experience: attrs["years_of_experience"],
    category:            attrs["category"],
    icon:                attrs["icon"],
    description_en:      en["description"],
    description_nl:      nl["description"],
    description_de:      de["description"]
  )
  experience.save!

  attrs["skills"].each do |skill_key|
    skill = skill_index.fetch(skill_key)
    ExperienceSkill.find_or_create_by!(experience: experience, skill: skill)
  end
end

# Jobs
data["jobs"].each do |attrs|
  en = attrs["translations"]["en"]
  nl = attrs["translations"]["nl"]
  de = attrs["translations"]["de"]

  job = Job.find_or_initialize_by(title_en: en["title"], company: attrs["company"])
  job.assign_attributes(
    company:        attrs["company"],
    logo:           attrs["logo"],
    start_date:     attrs["start_date"],
    end_date:       attrs["end_date"],
    title_en:       en["title"],
    title_nl:       nl["title"],
    title_de:       de["title"],
    description_en: en["description"],
    description_nl: nl["description"],
    description_de: de["description"]
  )
  job.save!

  attrs["skills"].each do |skill_key|
    skill = skill_index.fetch(skill_key)
    skill_data = data["skills"].find { |s| s["key"] == skill_key }
    js = JobSkill.find_or_initialize_by(job: job, skill: skill)
    js.category ||= skill_data["category"]
    js.save!
  end
end

# Projects
data["projects"].each do |attrs|
  en = attrs["translations"]["en"]
  nl = attrs["translations"]["nl"]
  de = attrs["translations"]["de"]

  project = Project.find_or_initialize_by(name: en["name"])
  project.assign_attributes(
    position:       attrs["position"],
    year:           attrs["year"],
    url:            attrs["url"],
    repo_url:       attrs["repo_url"],
    description_en: en["description"],
    description_nl: nl["description"],
    description_de: de["description"]
  )
  project.save!

  attrs["skills"].each do |skill_key|
    skill = skill_index[skill_key]
    next if skill.nil?
    ProjectSkill.find_or_create_by!(project: project, skill: skill)
  end
end
