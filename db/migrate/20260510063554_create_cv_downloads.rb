class CreateCvDownloads < ActiveRecord::Migration[8.1]
  def change
    create_table :cv_downloads do |t|
      t.string :email
      t.string :token
      t.datetime :requested_at
      t.datetime :approved_at
      t.integer :download_count, default: 0, null: false
      t.datetime :last_download_at

      t.timestamps
    end
    add_index :cv_downloads, :token, unique: true
  end
end
