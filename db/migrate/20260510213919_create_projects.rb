class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :repo_url
      t.integer :year
      t.integer :position

      t.timestamps
    end
  end
end
