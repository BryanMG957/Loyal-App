class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.datetime :date_received
      t.decimal :amount
      t.string :type
      t.string :ref
      t.string :memo
      t.references :client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
