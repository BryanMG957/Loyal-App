class AddColorToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :color, :string
  end
end
