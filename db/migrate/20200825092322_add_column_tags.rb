class AddColumnTags < ActiveRecord::Migration[6.0]
  def change
    remove_column :tags, :tag

    add_column :tags, :name, :string
  end
end
