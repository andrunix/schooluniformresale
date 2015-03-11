class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :phone
      t.string :zip
      t.belongs_to :role, index: true

      t.timestamps null: false
    end
    #add_foreign_key :users, :roles
  end
end
