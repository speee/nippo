class AddSentAtIndexToNippos < ActiveRecord::Migration[5.0]
  def change
    add_index :nippos, :sent_at
  end
end
