class AddRefreshTokenColumnToUser < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :token, :refresh_token
  end
end
