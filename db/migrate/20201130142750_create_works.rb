class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|

      t.integer :post_id, null: false
      t.json :images
      t.text :detail, null: false

      t.timestamps
    end
    add_index :works, :post_id
  end
end
