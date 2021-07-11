class CreateProductPictures < ActiveRecord::Migration[6.1]
  def change
    create_table :product_pictures do |t|
      t.string :picture
      t.references :product, null: false, foreign_key: true
      t.integer :picture_size
      t.integer :picture_height
      t.integer :picture_width
      t.boolean :processed, default: false
      t.string :picture_name

      t.timestamps
    end
  end
end
