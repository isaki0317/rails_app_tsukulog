class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|

      t.integer :end_user_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
