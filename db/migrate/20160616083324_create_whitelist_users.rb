class CreateWhitelistUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :whitelist_users do |t|
      t.string :email, null: false, limit: 128

      t.timestamps
    end

    add_index :whitelist_users, :email, unique: true
  end
end
