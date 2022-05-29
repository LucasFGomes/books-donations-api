class AddColumnsToCities < ActiveRecord::Migration[7.0]
  def change
    add_column :cities, :code, :string
    add_column :cities, :capital, :boolean, default: false
  end
end
