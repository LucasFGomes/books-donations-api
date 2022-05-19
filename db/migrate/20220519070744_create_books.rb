class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :resume
      t.integer :year
      t.decimal :credit
      t.references :user, null: false, foreign_key: true
      t.boolean :has_interest
      t.boolean :donated

      t.timestamps
    end
  end
end
