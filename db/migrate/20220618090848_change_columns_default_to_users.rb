class ChangeColumnsDefaultToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :count_note, :integer, default: 0
    change_column :users, :sum_notes, :integer, default: 0
  end
end
