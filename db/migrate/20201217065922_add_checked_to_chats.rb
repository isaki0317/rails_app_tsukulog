class AddCheckedToChats < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :checked, :boolean, default: false, null: false
  end
end
