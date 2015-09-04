class AddExpirationToItems < ActiveRecord::Migration
  def change
    add_column :items, :expires_on, :datetime
  end
end
