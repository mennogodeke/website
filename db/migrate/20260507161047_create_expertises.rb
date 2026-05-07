class CreateExpertises < ActiveRecord::Migration[8.1]
  def change
    create_table :expertises do |t|
      t.string :name
      t.text :description
      t.integer :years_of_experience

      t.timestamps
    end
  end
end
