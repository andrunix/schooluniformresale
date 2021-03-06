class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role

  has_many :users_schools
  has_and_belongs_to_many :schools, join_table: :users_schools
  has_many :sent_messages, foreign_key: :from_user_id, class_name: "Message"
  has_many :incoming_messages, foreign_key: :to_user_id, class_name: "Message"

  has_many :items
  has_many :favorites

  has_many :user_friends
  has_many :friends, through: :user_friends

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

  def regular?
      self.role.name == "Regular"
  end

  def address
    "#{self.city}, #{self.state}" if self.city.present? && self.state.present?
  end

  def item_in_favorites?(id) 
    !(self.favorites.index { |f| f.item_id == id }).nil?
  end

  # pass a user Id and return true if it is in the current user's list of friends
  def friends?(id)
    !(self.friends.index { |f| f.id == id }).nil?
  end

  def friend_date(id) 
    # find the user_friend for this user
    uf = self.user_friends.find { |x| x.friend_id == id }
    uf.add_date.strftime("%b %e %Y")
  end

  def find_favorite(id) 
    self.favorites.find { |f| f.item_id == id }
  end

  def unread_messages
    self.incoming_messages.select { |i| i.unread == true }
  end

  def top_friends
    # this is an arbitrary limit on how many friends to show
    self.friends.limit(4)
  end

end
