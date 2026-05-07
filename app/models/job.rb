class Job < ApplicationRecord
  validates :title, :company, :start_date, presence: true
end
