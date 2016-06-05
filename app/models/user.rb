class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :login
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :comments

  has_many :created_projects, :foreign_key => "creator_id", :class_name => "Project"
  has_many :commented_projects, through: :comments, :class_name => "Project"
  
  validates_presence_of :name 
  validates_uniqueness_of :name 

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.save!
    end 
  end

  #changing the behavior of the login action so overwrite the find_for_database_authentication method. 
  #allows you to redefine authentication
  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
  end

end
