class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :color
      t.references :category, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
