class CreatePostTags < ActiveRecord::Migration[6.0]
  def change
    create_table :post_tags do |t|

      t.timestamps
    end
  end
end
