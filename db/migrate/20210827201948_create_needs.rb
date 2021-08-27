class CreateNeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :needs do |t|
      t.string :point_of_contact
      t.string :title
      t.string :description
      t.string :start_time
      t.string :end_time
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.integer :supporters_needed
      t.integer :status

      t.timestamps
    end
  end
end
