class CreateSupporters < ActiveRecord::Migration[5.2]
  def change
    create_table :supporters do |t|
      t.string :name
      t.string :email
      t.references :need, foreign_key: true

      t.timestamps
    end
  end
end
