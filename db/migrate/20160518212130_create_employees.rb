class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
