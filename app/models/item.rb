class Item < ActiveRecord::Base
  belongs_to :user

  belongs_to :category
  belongs_to :condition
  belongs_to :school
  has_many :messages

end
