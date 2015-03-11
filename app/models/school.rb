class School < ActiveRecord::Base
  has_many :users_schools
  has_many :items
  has_and_belongs_to_many :users, join_table: :users_schools

  validates_presence_of :name
  validates_presence_of :zip

  def formatted_address 
    retval = ""
    retval += "#{self.address1}<br/>" unless self.address1.blank?
    retval += "#{self.address2}<br/>" unless self.address2.blank?
    retval += "#{self.city}, " unless self.city.blank?
    retval += "#{self.state} " unless self.state.blank?
    retval += "#{self.zip}" unless self.zip.blank?
  end
end
