class AddArchivedToPets < ActiveRecord::Migration
  def change
    add_column :pets, :archived, :boolean, default: false
  end
end
