class Micropost < ActiveRecord::Base
  
  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :content, :course_id, :photo, :user_id
  belongs_to :user
  attr_accessor :current_user

  #########################################
  # I dont have validates set up for all my things, perhaps i do?
  #########################################
  validates :user_id, presence: true
  validates :content, length: { maximum: 300 }
  default_scope order: 'microposts.created_at DESC'

  #########################################
  # paperclip photos
  #########################################
  has_attached_file :photo, :styles => { :small => "640x640#" },
                            :default_url => 'missing_photo.png'

  def photo_url
    photo.url(:small)
  end

end