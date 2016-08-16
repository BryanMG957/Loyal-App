class AddArchivedToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :archived, :boolean, default: false
  end
end
