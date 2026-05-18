class Expertise < ApplicationRecord
  has_many :expertise_skills, dependent: :destroy
  has_many :skills, through: :expertise_skills

  translates :description

  enum :category, {
    frontend:             0,
    backend:              1,
    fullstack:            2,
    devops:               3,
    platform:             4,
    apps:                 5,
    programming_language: 6,
    other:                7
  }

  validates :name, :years_of_experience, presence: true

  default_scope { order(years_of_experience: :desc) }
end
