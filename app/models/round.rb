class Round < ActiveRecord::Base
  
  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :scorecard_id, :user_id, :event_id, :tee, :score_front, :score_back, :score_total, :handicap_used, :complete, :playdate

  #########################################
  # custom
  #########################################
  belongs_to :scorecard
  belongs_to :user
  belongs_to :event
  has_many :holes
  
end

