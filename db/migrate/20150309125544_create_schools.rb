class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :description
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :url
      t.string :email
      t.boolean :approved
      t.integer :created_by

      t.timestamps null: false
    end
  end
end
