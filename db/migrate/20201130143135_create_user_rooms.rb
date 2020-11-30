class CreateUserRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :user_rooms do |t|

      t.integer :end_user_id, null: false
      t.integer :room_id, null: false

      t.timestamps
    end
  end
end
