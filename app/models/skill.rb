class Skill < ApplicationRecord
  has_many :experience_skills, dependent: :destroy
  has_many :experiences, through: :experience_skills
  has_many :job_skills, dependent: :destroy
  has_many :jobs, through: :job_skills
  has_many :project_skills, dependent: :destroy
  has_many :projects, through: :project_skills

  translates :description

  enum :level, { familiar: 1, proficient: 2, expert: 3 }

  validates :name, :level, presence: true

  def accent
    super.presence || "var(--color-text-faint)"
  end
end
