class ChangeColumnsToDonations < ActiveRecord::Migration[7.0]
  def change
    change_column :donations, :status, :string, default: 'processing'
  end
end
