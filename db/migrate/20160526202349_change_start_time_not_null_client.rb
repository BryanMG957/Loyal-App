class ChangeStartTimeNotNullClient < ActiveRecord::Migration
  def change
    change_column :employees, :first_name, :string, null: false
    change_column :employees, :last_name, :string, null: false
    change_column :clients, :first_name, :string, null: false
    change_column :clients, :last_name, :string, null: false
  end
end
