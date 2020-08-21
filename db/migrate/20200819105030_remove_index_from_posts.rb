class RemoveIndexFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_index :posts, :title
    add_index :posts, :title
  end
end
