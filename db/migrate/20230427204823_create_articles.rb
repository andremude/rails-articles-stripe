class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.text :preview
      t.boolean :private, default: false

      t.timestamps
    end
  end
end
