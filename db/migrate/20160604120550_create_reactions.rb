class CreateReactions < ActiveRecord::Migration[5.0]
  def change
    create_table :reactions do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :nippo, foreign_key: true, null: false
      t.integer :page_view, null: false, default: 0

      t.timestamps
    end

    add_index :reactions, %i(user_id nippo_id), unique: true
  end
end
