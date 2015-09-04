class AddQuantityAndBrandToItems < ActiveRecord::Migration
  def change
    add_column :items, :brand, :string
    add_column :items, :quantity, :integer
  end
end
