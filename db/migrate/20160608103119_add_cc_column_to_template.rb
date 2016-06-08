class AddCcColumnToTemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :cc, :text
  end
end
