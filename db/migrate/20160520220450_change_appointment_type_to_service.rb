class ChangeAppointmentTypeToService < ActiveRecord::Migration
  def change
  	remove_column :appointments, :type, :string
  	add_column :appointments, :service, :string
  end
end
