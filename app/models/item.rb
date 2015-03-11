class Item < ActiveRecord::Base
  belongs_to :user

  belongs_to :category
  belongs_to :condition
  belongs_to :school
  has_many :messages
  has_many :favorites
  has_and_belongs_to_many :users, join_table: :favorites

end
