class AddArticlesIdsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :article_ids, :json, default: []
  end
end
