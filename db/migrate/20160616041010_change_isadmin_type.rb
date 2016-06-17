class ChangeIsadminType < ActiveRecord::Migration
  def change
  	remove_column :employees, :is_admin
  	add_column :employees, :is_admin?, :boolean
  	remove_column :employees, :is_superuser
  	add_column :employees, :is_superuser?, :boolean
  end
end
