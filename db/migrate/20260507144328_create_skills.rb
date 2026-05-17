class CreateSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :skills do |t|
      t.string :name
      t.text :description_en
      t.text :description_nl
      t.text :description_de
      t.integer :level
      t.string :icon
      t.string :accent

      t.timestamps
    end
  end
end
