class RemoveTitleFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :date, :datetime
  end
end
