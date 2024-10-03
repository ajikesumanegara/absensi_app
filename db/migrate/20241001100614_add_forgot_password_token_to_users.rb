class AddForgotPasswordTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :forgot_password_token, :string
    add_column :users, :forgot_password_token_expired_at, :datetime
  end
end
