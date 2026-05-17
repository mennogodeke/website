class CreateExpertises < ActiveRecord::Migration[8.1]
  def change
    create_table :expertises do |t|
      t.string :name
      t.text :description_en
      t.text :description_nl
      t.text :description_de
      t.integer :years_of_experience
      t.string :icon
      t.string :accent

      t.timestamps
    end
  end
end
