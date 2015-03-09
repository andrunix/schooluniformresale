class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.integer :parent_message_id
      t.string :subject
      t.string :message
      t.integer :item_id
      t.boolean :unread
      t.integer :folder_id

      t.timestamps null: false
    end
  end
end
