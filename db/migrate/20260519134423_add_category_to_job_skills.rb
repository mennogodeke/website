class AddCategoryToJobSkills < ActiveRecord::Migration[8.1]
  def change
    add_column :job_skills, :category, :integer
  end
end
