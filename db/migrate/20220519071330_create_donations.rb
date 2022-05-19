class CreateDonations < ActiveRecord::Migration[7.0]
  def change
    create_table :donations do |t|
      t.string :address
      t.string :status
      t.date :date_delivery
      t.references :book, null: false, foreign_key: true
      t.integer :receiver_id
      t.boolean :donor_evaluation, default: false
      t.boolean :receiver_evaluation, default: false
      t.integer :donor_note
      t.integer :receiver_note

      t.timestamps
    end
  end
end
