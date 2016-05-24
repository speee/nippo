class CreateNippos < ActiveRecord::Migration[5.0]
  def change
    create_table :nippos do |t|
      t.belongs_to :user, foreign_key: true, null: false

      t.date :reported_for, null: false
      t.text :subject_yaml
      t.text :body
      t.datetime :sent_at

      t.timestamps
    end

    add_index :nippos, %i(user_id reported_for), unique: true
  end
end
