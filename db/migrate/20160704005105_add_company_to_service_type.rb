class AddCompanyToServiceType < ActiveRecord::Migration
  def change
    add_reference :service_types, :company, index: true, foreign_key: true
  end
end
