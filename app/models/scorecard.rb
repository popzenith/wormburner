class Scorecard < ActiveRecord::Base

  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :course_id, :tee_id, :course_code, :tee_name, :tee_color, :course_par_for_tee, :hole1, :hole2, :hole3, :hole4, :hole5, :hole6, :hole7, :hole8, :hole9, :hole10, :hole11, :hole12, :hole13, :hole14, :hole15, :hole16, :hole17, :hole18, :total_distance, :hole1_par, :hole2_par, :hole3_par, :hole4_par, :hole5_par, :hole6_par, :hole7_par, :hole8_par, :hole9_par, :hole10_par, :hole11_par, :hole12_par, :hole13_par, :hole14_par, :hole15_par, :hole16_par, :hole17_par, :hole18_par, :hole1_handicap, :hole2_handicap, :hole3_handicap, :hole4_handicap, :hole5_handicap, :hole6_handicap, :hole7_handicap, :hole8_handicap, :hole9_handicap, :hole10_handicap, :hole11_handicap, :hole12_handicap, :hole13_handicap, :hole14_handicap, :hole15_handicap, :hole16_handicap, :hole17_handicap, :hole18_handicap, :rating, :slope

  #########################################
  # custom 
  #########################################
	belongs_to :course
    has_many :rounds
    
end
