class AddOwnerIdToCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :owner, :integer
  end
end
