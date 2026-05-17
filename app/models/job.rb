class Job < ApplicationRecord
  has_many :job_skills, dependent: :destroy
  has_many :skills, through: :job_skills

  translates :title, :description

  validates :title, :company, :start_date, presence: true
end
