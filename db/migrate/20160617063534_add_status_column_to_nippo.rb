class AddStatusColumnToNippo < ActiveRecord::Migration[5.0]
  def up
    add_column :nippos, :status, :integer, null: false, default: 0
    execute 'UPDATE nippos SET status = 2 WHERE sent_at IS NOT NULL;'
  end

  def down
    remove_column :nippos, :status
  end
end
