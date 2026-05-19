class JobSkill < ApplicationRecord
  belongs_to :job
  belongs_to :skill

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
end
