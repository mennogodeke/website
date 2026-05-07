class Skill < ApplicationRecord
  enum :level, { familiar: 1, proficient: 2, expert: 3 }

  validates :name, :level, presence: true
end
