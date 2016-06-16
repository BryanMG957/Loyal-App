class RemoveEmployeeFromCalendar < ActiveRecord::Migration
  def change
  	remove_column :employees, :calendar_id
  end
end
