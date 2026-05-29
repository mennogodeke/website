class RemoveAccentFromProjects < ActiveRecord::Migration[8.1]
  def change
    remove_column :projects, :accent, :string
  end
end
