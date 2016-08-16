class AddArchivedToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :archived, :boolean, default: false
  end
end
