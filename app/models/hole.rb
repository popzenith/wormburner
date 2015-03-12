class Hole < ActiveRecord::Base
  
  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :round_id, :hole_number, :score_total, :putts, :penalty, :fairway, :green, :sand, :scramble, :holepar, :holehandicap

  #########################################
  # custom
  #########################################
  belongs_to :round
  
end