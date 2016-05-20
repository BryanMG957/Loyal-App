class AddDescriptionToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :description, :string
  end
end
