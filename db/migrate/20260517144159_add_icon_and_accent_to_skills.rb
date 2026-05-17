class AddIconAndAccentToSkills < ActiveRecord::Migration[8.1]
  def change
    add_column :skills, :icon, :string
    add_column :skills, :accent, :string
  end
end
