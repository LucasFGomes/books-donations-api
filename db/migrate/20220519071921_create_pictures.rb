class CreatePictures < ActiveRecord::Migration[7.0]
  def change
    create_table :pictures do |t|
      t.string :url
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
