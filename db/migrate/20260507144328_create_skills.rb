class CreateSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :skills do |t|
      t.string :name
      t.text :description
      t.integer :level

      t.timestamps
    end
  end
end
