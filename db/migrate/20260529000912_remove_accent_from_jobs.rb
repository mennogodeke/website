class RemoveAccentFromJobs < ActiveRecord::Migration[8.1]
  def change
    remove_column :jobs, :accent, :string
  end
end
