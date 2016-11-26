class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer 'type', limit: 1,  null: false
      t.string 'title', limit: 64, null: false

      t.timestamps
    end
  end
end
