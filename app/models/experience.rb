class Experience < ApplicationRecord
  has_many :experience_skills, dependent: :destroy
  has_many :skills, through: :experience_skills

  translates :description

  enum :category, {
    ai:                   0,
    backend:              1,
    fullstack:            2,
    devops:               3,
    infra:                4,
    apps:                 5,
    programming_language: 6,
    other:                7
  }

  validates :name, :years_of_experience, presence: true

  default_scope { order(years_of_experience: :desc) }
end
