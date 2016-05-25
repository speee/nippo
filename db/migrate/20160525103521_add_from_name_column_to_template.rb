class AddFromNameColumnToTemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :from_name, :string, limit: 64
  end
end
