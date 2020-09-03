class ChangeTrashesToTrashObjects < ActiveRecord::Migration[6.0]
  def change
    rename_table :likes, :goods
  end
end
