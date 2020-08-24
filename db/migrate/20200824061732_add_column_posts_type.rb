class AddColumnPostsType < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :type, :integer 
  end
end
