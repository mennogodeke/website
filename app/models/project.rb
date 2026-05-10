class Project < ApplicationRecord
  has_many :project_skills, dependent: :destroy
  has_many :skills, through: :project_skills

  validates :name, presence: true

  default_scope { order(position: :asc) }
end
