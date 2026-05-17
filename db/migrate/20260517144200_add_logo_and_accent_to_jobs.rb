class AddLogoAndAccentToJobs < ActiveRecord::Migration[8.1]
  def change
    add_column :jobs, :logo, :string
    add_column :jobs, :accent, :string
  end
end
