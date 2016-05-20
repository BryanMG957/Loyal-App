class ChangeCalendarTypeToApitype < ActiveRecord::Migration
  def change
  	remove_column :calendars, :type, :string
  	add_column :calendars, :apitype, :string
  end
end
