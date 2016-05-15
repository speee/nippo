class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email,    null: false, limit: 128
      t.string :provider, null: false, limit: 32
      t.string :uid,      null: false, limit: 32
      t.string :name,     null: false, limit: 64
      t.string :image,    null: false, limit: 128
      t.string :token,    null: false, limit: 128

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
