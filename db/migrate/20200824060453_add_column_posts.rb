class AddColumnPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :type

    add_column :posts, :type, :integer 
  end
end
