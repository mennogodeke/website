require "yaml"

data = YAML.load_file(Rails.root.join("CONTENT_DATA.yml"))

# Skills
data["skills"].each do |attrs|
  en = attrs["translations"]["en"]
  nl = attrs["translations"]["nl"]
  de = attrs["translations"]["de"]

  skill = Skill.find_or_initialize_by(name: en["name"])
  skill.assign_attributes(
    level:           attrs["level"],
    icon:            attrs["icon"],
    description_en:  en["description"],
    description_nl:  nl["description"],
    description_de:  de["description"]
  )
  skill.save!
end

# Expertises
data["expertises"].each do |attrs|
  en = attrs["translations"]["en"]
  nl = attrs["translations"]["nl"]
  de = attrs["translations"]["de"]

  expertise = Expertise.find_or_initialize_by(name: en["name"])
  expertise.assign_attributes(
    years_of_experience: attrs["years_of_experience"],
    icon:                attrs["icon"],
    description_en:      en["description"],
    description_nl:      nl["description"],
    description_de:      de["description"]
  )
  expertise.save!

  attrs["skills"].each do |skill_key|
    skill_data = data["skills"].find { |s| s["key"] == skill_key }
    skill = Skill.find_by!(name: skill_data["translations"]["en"]["name"])
    ExpertiseSkill.find_or_create_by!(expertise: expertise, skill: skill)
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
    skill_data = data["skills"].find { |s| s["key"] == skill_key }
    skill = Skill.find_by!(name: skill_data["translations"]["en"]["name"])
    JobSkill.find_or_create_by!(job: job, skill: skill)
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
    skill_data = data["skills"].find { |s| s["key"] == skill_key }
    next if skill_data.nil?
    skill = Skill.find_by!(name: skill_data["translations"]["en"]["name"])
    ProjectSkill.find_or_create_by!(project: project, skill: skill)
  end
end
