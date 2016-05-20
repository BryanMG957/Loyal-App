class AddUrlToCalendar < ActiveRecord::Migration
  def change
  	add_column :calendars, :url, :string
  	add_column :calendars, :uid, :string
  end
end
