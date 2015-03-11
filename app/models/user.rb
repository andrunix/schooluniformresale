class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role

  has_many :users_schools
  has_and_belongs_to_many :schools, join_table: :users_schools
  has_many :messages, foreign_key: :from_user_id
  has_many :incoming_messages, foreign_key: :to_user_id, class_name: "Message"

  has_many :items
  has_many :favorites


  validates_presence_of :fname
  validates_presence_of :lname
  validates_presence_of :email

  before_save :assign_role

  def name
    "#{self.fname} #{self.lname}"
  end

  def last_first
    "#{self.lname}, #{self.fname}"
  end

  def assign_role
      self.role = Role.find_by name: "Regular" if self.role.nil?
  end

  def admin?
    self.role.name == "Admin"
  end

  # def seller?
  #     self.role.name == "Seller"
  # end

  def regular?
      self.role.name == "Regular"
  end

end
