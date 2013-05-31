class User < ActiveRecord::Base

  attr_accessible :first_name, :last_name, :login, :email, :password,
                  :password_confirmation, :remember_me, :confirmed_at, :avatar,
                  :profile , :haslocalpw , :roles, :role, :roles_mask

  validates_uniqueness_of :login, :email , :case_sensitive => false
  validates :email, :email_format => true
  validates_presence_of :first_name, :last_name, :email, :password, :password_confirmation
  validates_length_of :first_name, :last_name,
                      :minimum => 1,
                      :maximum => 50

  devise :database_authenticatable,  :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :confirmable

  has_many :services, :dependent => :destroy
  has_and_belongs_to_many :channels
  has_many :comments
  #has_many :feeds

  has_attached_file :avatar, :styles => { :large => "400x400>", :medium => "200x200",:thumb => "100x100>" }

  #has_and_belongs_to_many :roles, :join_table => :users_roles
  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "} }

  ROLES = %w[basic medium premium]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def self.last_feeds
    @users = User.all
    @users.each do |user|
      FeedsMailer.last_feeds_email(user).deliver
    end
  end

  def display_name
    first_name.capitalize.to_s + ' ' + last_name.capitalize
  end

end
