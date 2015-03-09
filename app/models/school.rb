class School < ActiveRecord::Base
  has_many :users_schools
  has_and_belongs_to_many :users, join_table: :users_schools

  validates_presence_of :name
  validates_presence_of :zip

end
