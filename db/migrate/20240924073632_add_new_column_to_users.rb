class AddNewColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :email, :string
    add_column :users, :invite_token, :string
    add_column :users, :invite_token_expired_at, :datetime
  end
end
