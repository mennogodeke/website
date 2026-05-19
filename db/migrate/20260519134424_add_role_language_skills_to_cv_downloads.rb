class AddRoleLanguageSkillsToCvDownloads < ActiveRecord::Migration[8.1]
  def change
    add_column :cv_downloads, :role, :integer
    add_column :cv_downloads, :language, :integer
    add_column :cv_downloads, :skills, :text, array: true, default: []
  end
end
