class AddIconAndAccentToExpertises < ActiveRecord::Migration[8.1]
  def change
    add_column :expertises, :icon, :string
    add_column :expertises, :accent, :string
  end
end
