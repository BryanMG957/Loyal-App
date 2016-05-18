class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone1
      t.string :phone2
      t.string :phone3
      t.string :phone4
      t.string :address
      t.text :notes
      t.references :company, index: true, foreign_key: true
      t.string :first_name_2
      t.string :last_name_2

      t.timestamps null: false
    end
  end
end
