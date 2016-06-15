class AddUserIdAndProviderToEmployee < ActiveRecord::Migration
  def change
  	add_column :employees, :user_id, :string
  	add_column :employees, :provider, :string
  	add_column :employees, :is_admin, :string
  end
end
