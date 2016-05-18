class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :type
      t.datetime :start_time
      t.datetime :end_time
      t.integer :charge
      t.integer :reminder_before
      t.integer :reminder_after
      t.string :status
      t.text :notes
      t.references :calendar, index: true, foreign_key: true
      t.references :client, index: true, foreign_key: true
      t.references :bill, index: true, foreign_key: true
      t.references :employee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
