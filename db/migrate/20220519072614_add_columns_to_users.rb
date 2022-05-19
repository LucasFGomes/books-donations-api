class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :credits, :decimal
    add_column :users, :points, :decimal
    add_column :users, :phone, :string
    add_reference :users, :city, foreign_key: true
    add_column :users, :count_note, :integer
    add_column :users, :sum_notes, :integer
  end
end
