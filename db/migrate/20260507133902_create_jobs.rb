class CreateJobs < ActiveRecord::Migration[8.1]
  def change
    create_table :jobs do |t|
      t.string :title_en
      t.string :title_nl
      t.string :title_de
      t.string :company
      t.text :description_en
      t.text :description_nl
      t.text :description_de
      t.date :start_date
      t.date :end_date
      t.string :logo
      t.string :accent

      t.timestamps
    end
  end
end
