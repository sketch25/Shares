class AddHashtagToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :hashtag, :string
  end
end
