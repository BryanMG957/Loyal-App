class AddUuidtoAppointment < ActiveRecord::Migration
  def change
  	add_column :appointments, :uuid, :string
  end
end
