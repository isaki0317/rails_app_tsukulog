class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|

      t.integer :end_user_id, null: false
      t.integer :genre_id, null: false
      t.string :title, null: false
      t.string :subtitle, null: false
      t.text :tool
      t.json :images, null: false
      t.integer :cost, null: false, default: 0
      t.integer :creation_time, null: false, default: 0
      t.integer :level, null: false, default: 0
      t.text :caution
      t.string :link
      t.boolean :post_status, null: false, default: true


      t.timestamps
    end
  end
end
