class Expertise < ApplicationRecord
  has_many :expertise_skills, dependent: :destroy
  has_many :skills, through: :expertise_skills

  translates :description

  validates :name, :years_of_experience, presence: true

  default_scope { order(years_of_experience: :desc) }
end
