class ChangeStartTimeNotNullClientc < ActiveRecord::Migration
  def change
    change_column :employees, :first_name, :string, null: false
    change_column :employees, :first_name, :string, null: false
    change_column :clients, :first_name, :string, null: false
    change_column :clients, :first_name, :string, null: false
  end
end