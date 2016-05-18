class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :total_amount
      t.integer :paid_amount
      t.datetime :date_billed
      t.datetime :date_paid
      t.integer :discount
      t.references :client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
