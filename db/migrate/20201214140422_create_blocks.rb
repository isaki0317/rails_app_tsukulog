class CreateBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :blocks do |t|

      t.integer :blocker_id, null: false
      t.integer :blocked_id, null: false

      t.timestamps
    end
  end
end
