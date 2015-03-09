class Message < ActiveRecord::Base
  belongs_to :user, foreign_key: :from_user_id
  belongs_to :item 

end
