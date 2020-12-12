class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|

      t.integer :post_id, null: false
      t.string :material_name, null: false
      t.string :shop

      t.timestamps
    end
    add_index :materials, :post_id
  end
end
