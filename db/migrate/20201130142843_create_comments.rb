class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|

      t.integer :post_id, null: false
      t.integer :end_user_id, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
