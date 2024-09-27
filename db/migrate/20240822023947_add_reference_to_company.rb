class AddReferenceToCompany < ActiveRecord::Migration[7.0]
  def change
    remove_column :companies, :owner, :integer
  end
end
