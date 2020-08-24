class AddDatailsToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :type, :string ,null: false
  end
end
