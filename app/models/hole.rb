class Hole < ActiveRecord::Base
  
  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :round_id, :hole_number, :score_total, :score_total_esc, :strikes, :putts, :penalty, :fairway, :green, :sand, :scramble, :holepar, :holehandicap

  #########################################
  # custom
  #########################################
  belongs_to :round
  default_scope order: 'holes.hole_number ASC'
  
end