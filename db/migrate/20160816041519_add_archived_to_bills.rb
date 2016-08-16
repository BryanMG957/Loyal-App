class AddArchivedToBills < ActiveRecord::Migration
  def change
    add_column :bills, :archived, :boolean, default: false
  end
end
