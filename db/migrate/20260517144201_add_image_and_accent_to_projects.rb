class AddImageAndAccentToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :image, :string
    add_column :projects, :accent, :string
  end
end
