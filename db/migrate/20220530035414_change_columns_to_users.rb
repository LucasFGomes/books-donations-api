class ChangeColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :credits, :decimal, default: 0.0
    change_column :users, :points, :decimal, default: 0.0
  end
end
