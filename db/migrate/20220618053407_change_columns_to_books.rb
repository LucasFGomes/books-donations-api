class ChangeColumnsToBooks < ActiveRecord::Migration[7.0]
  def change
    change_column :books, :has_interest, :boolean, default: false
    change_column :books, :donated, :boolean, default: false
  end
end
