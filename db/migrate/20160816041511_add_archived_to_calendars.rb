class AddArchivedToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :archived, :boolean, default: false
  end
end
