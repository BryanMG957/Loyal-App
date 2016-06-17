class AddSuperuserToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :is_superuser, :boolean
  end
end
