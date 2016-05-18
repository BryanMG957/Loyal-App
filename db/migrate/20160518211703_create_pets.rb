class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.text :notes
      t.references :client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
