class RenameForgotPasswordTokenColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :forgot_password_token, :reset_password_token
    rename_column :users, :forgot_password_token_expired_at, :reset_password_token_expired_at
  end
end
