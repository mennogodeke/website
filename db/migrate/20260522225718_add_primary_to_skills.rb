class AddPrimaryToSkills < ActiveRecord::Migration[8.1]
  def change
    add_column :skills, :primary, :boolean, default: false, null: false
  end
end
