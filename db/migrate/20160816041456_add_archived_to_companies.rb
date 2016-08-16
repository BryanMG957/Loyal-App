class AddArchivedToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :archived, :boolean, default: false
  end
end
