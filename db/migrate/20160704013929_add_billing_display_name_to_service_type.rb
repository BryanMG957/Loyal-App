class AddBillingDisplayNameToServiceType < ActiveRecord::Migration
  def change
    add_column :service_types, :billing_display_name, :string
  end
end
