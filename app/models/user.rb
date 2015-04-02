class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :invitable

  before_save :ensure_authentication_token

  validates_length_of :name, :minimum => 1, :maximum => 50
  validates_uniqueness_of :name

  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :name, :email, :current_password, :password, :password_confirmation, :remember_me, :photo, :invitation_token, :invited_by_id, :invited_by_type, :notify, :buddy, :gender, :displayname
  attr_accessor :current_password

  #########################################
  # custom 
  #########################################
  has_many :user_events
  has_many :events, through: :user_events
  has_many :rounds
  has_many :holes, through: :rounds
            
  #########################################
  # paperclip profile photo
  #########################################
  has_attached_file :photo, :styles => { :small => "300x300#" },
                            :default_url => 'missing_:style.png'

  #########################################
  # these methods can be called from the controller to get data from other models 
  # look in the controller and see these get called 
  #########################################      

  # profile photos
  def photo_url
    photo.url(:small)
  end

  # search
  def self.search(search)
    order('name ASC').where('lower(name) LIKE ?', "%#{search.downcase}%").limit(50)
  end

  def self.searchbyemail(email)
    where('lower(email) = ?', email.downcase)
  end

end
