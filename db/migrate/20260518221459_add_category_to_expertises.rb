class AddCategoryToExpertises < ActiveRecord::Migration[8.1]
  def change
    add_column :expertises, :category, :integer
  end
end
