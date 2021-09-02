class CreateNeedCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :need_categories do |t|
      t.integer :category_id, foreign_key: true
      t.integer :need_id, foreign_key: true

      t.timestamps
    end
  end
end
