class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description_en
      t.text :description_nl
      t.text :description_de
      t.string :url
      t.string :repo_url
      t.integer :year
      t.integer :position
      t.string :image
      t.string :accent

      t.timestamps
    end
  end
end
