class AddCalendarToEmployee < ActiveRecord::Migration
  def change
    add_reference :employees, :calendar, index: true, foreign_key: true
  end
end
