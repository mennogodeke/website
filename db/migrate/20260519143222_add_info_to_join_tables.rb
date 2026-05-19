class AddInfoToJoinTables < ActiveRecord::Migration[8.1]
  def change
    add_column :project_skills, :info, :text
    add_column :experience_skills, :info, :text
    add_column :job_skills, :info, :text
  end
end
