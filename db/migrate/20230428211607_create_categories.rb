class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :stripe_pricing_id
      t.string :stripe_product_id
      t.integer :price

      t.timestamps
    end
  end
end
