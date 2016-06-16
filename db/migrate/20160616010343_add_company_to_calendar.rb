class AddCompanyToCalendar < ActiveRecord::Migration
  def change
    add_reference :calendars, :company, index: true, foreign_key: true
  end
end
