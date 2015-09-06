class Message < ActiveRecord::Base
  belongs_to :sender, foreign_key: :from_user_id, class_name: "User"
  belongs_to :item 
 end
