class RenameExpertisesToExperiences < ActiveRecord::Migration[8.1]
  def change
    rename_table :expertises, :experiences
    rename_table :expertise_skills, :experience_skills
    rename_column :experience_skills, :expertise_id, :experience_id
  end
end
