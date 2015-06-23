class Round < ActiveRecord::Base
  
  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :event_id, :user_id, :scorecard_id, :tee, :hol, :score_front, :score_back, :score_total, :course_handicap, :score_total_adj, :handicap_differential, :complete, :score_type, :playdate

  #########################################
  # custom
  #########################################
  belongs_to :scorecard
  belongs_to :user
  belongs_to :event
  has_many :holes, dependent: :destroy
  default_scope order: 'rounds.playdate DESC'
  
end

