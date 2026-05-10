class Skill < ApplicationRecord
  has_many :expertise_skills, dependent: :destroy
  has_many :expertises, through: :expertise_skills
  has_many :job_skills, dependent: :destroy
  has_many :jobs, through: :job_skills

  enum :level, { familiar: 1, proficient: 2, expert: 3 }

  validates :name, :level, presence: true
end
