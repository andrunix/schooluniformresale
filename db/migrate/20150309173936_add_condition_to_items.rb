class AddConditionToItems < ActiveRecord::Migration
  def change
    add_column :items, :condition_id, :integer
  end
end
