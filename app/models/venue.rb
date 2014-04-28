class Venue < ActiveRecord::Base

	#########################################
	# Setup accessible (or protected) attributes for your model
	#########################################
	attr_accessible :name

	#########################################
	# This refers to a join table, users can have many venues and venues can have many users, see the same thing in the other model
	#########################################
	#has_and_belongs_to_many :users, :uniq => true
	has_many :favorites, dependent: :destroy
  has_many :users,
  					:through => :favorites,
            class_name: "User",
            source: :user

	#########################################
	# these methods can be called from the controller to get data from other models 
	# look in the controller and see these get called 
	#########################################                       
	def feed
		Micropost.from_venue(self)
	end
end
