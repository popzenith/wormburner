class Course < ActiveRecord::Base

  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :facility_id, :course_code, :facility_code, :course_name, :hol, :par, :course_type, :course_architect, :open_date, :guest_policy, :weekday_price, :weekend_price, :twilight_price, :fairway, :green, :currency

  #########################################
  # custom 
  #########################################
  belongs_to :facility
  has_many :scorecards

end
