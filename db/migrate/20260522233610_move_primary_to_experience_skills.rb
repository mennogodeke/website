class MovePrimaryToExperienceSkills < ActiveRecord::Migration[8.1]
  def change
    add_column :experience_skills, :primary, :boolean, default: false, null: false
    remove_column :skills, :primary, :boolean
  end
end
