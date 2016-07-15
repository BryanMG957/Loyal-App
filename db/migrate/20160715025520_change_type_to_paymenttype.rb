class ChangeTypeToPaymenttype < ActiveRecord::Migration
  def change
    remove_column :payments, :type
    add_column :payments, :payment_type, :string
  end
end
