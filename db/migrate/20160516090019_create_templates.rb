class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.text :subject_yaml
      t.text :body

      t.timestamps
    end
  end
end
