class CreateNotificationFromAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :notification_from_admins do |t|
      t.belongs_to :notification, foreign_key: true, null: false

      t.text   'body'
      t.date   'expiration_date', null: false

      t.timestamps
    end
  end
end
