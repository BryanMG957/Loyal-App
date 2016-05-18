class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :name
      t.string :type
      t.string :server_incoming
      t.string :server_outgoing
      t.string :username
      t.string :password

      t.timestamps null: false
    end
  end
end
