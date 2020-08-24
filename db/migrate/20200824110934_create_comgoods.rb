class CreateComgoods < ActiveRecord::Migration[6.0]
  def change
    create_table :comgoods do |t|
      t.references :comment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
