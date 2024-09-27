class AddCompanyIdAndAsOwnerToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :company, foreign_key: true
    add_column :users, :as_owner?, :boolean, default: false
  end
end
