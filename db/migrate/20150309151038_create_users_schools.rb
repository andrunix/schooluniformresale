class CreateUsersSchools < ActiveRecord::Migration
  def self.up
    create_table :users_schools do |t|
      t.references :user
      t.references :school
    end
    add_index :users_schools, [:user_id, :school_id]
    add_index :users_schools, :user_id
  end

  def self.down
    drop_table :users_schools
  end
end
