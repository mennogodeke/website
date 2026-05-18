class RemoveAccentFromExpertises < ActiveRecord::Migration[8.1]
  def change
    remove_column :expertises, :accent, :string
  end
end
