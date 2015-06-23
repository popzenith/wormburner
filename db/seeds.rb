puts 'SETTING UP'

@user = User.find(1)
@date = "2015-04-01"

# for 1 to 50 rounds
r = 0
while r < 60
	r += 1

	randcourse = rand(6..12)
	@course = Course.find(randcourse) 
	@event = @user.events.create!(:course_id => @course.id, :owner_id => @user.id, :complete => "Y", :playdate => @date)

	randcard = rand(2058..2077)
	@scorecard = Scorecard.find(randcard) 
	@round = Round.create!(:event_id => @event.id, :user_id => @user.id, :scorecard_id => @scorecard.id, :tee => @scorecard.tee_color, :hol => 18, :score_front => 0, :score_back => 0, :score_total => 0, :course_handicap => 5, :score_total_adj => 0, :handicap_differential => 0, :complete => "Y", :score_type => "BYHOLE", :playdate => @date)

	# pars
	holepararray = [ "", @scorecard.hole1_par, @scorecard.hole2_par, @scorecard.hole3_par, @scorecard.hole4_par, @scorecard.hole5_par, @scorecard.hole6_par, @scorecard.hole7_par, @scorecard.hole8_par, @scorecard.hole9_par, @scorecard.hole10_par, @scorecard.hole11_par, @scorecard.hole12_par, @scorecard.hole13_par, @scorecard.hole14_par, @scorecard.hole15_par, @scorecard.hole16_par, @scorecard.hole17_par, @scorecard.hole18_par  ]

	# for 1 to 18 holes
	h = 0
	while h < 18
		h += 1

		# score
		rnd = rand(0..100)
		scorediff = 0
		if rnd == 0
			scorediff = -2
		elsif (1..9) === rnd
			scorediff = -1
		elsif (10..60) === rnd
			scorediff = 0
		elsif (61..90) === rnd
			scorediff = 1
		elsif (91..97) === rnd
			scorediff = 2
		elsif rnd >= 98
			scorediff = 3
		end
		holescore = holepararray[h] + scorediff
		if (h < 10) 
			@round.score_front += holescore
		else
			@round.score_back += holescore
		end

		# putts
		rnd = rand(0..100)
		if (0..5) === rnd
			putts = 0
		elsif (6..30) === rnd
			putts = 1
		elsif (31..90) === rnd
			putts = 2
		elsif rnd >= 91
			putts = 3
		end

		# fairway
		rnd = rand(0..100)
		if (0..55) === rnd
			fairway = "Y"
		elsif (56..65) === rnd
			fairway = "L"
		elsif (66..70) === rnd
			fairway = "R"
		elsif (71..75) === rnd
			fairway = "S"
		elsif (76..79) === rnd
			fairway = "F"
		elsif rnd >= 80
			fairway = ""
		end

		# green
		rnd = rand(0..100)
		if (0..65) === rnd
			green = "Y"
		elsif (66..76) === rnd
			green = "L"
		elsif (77..85) === rnd
			green = "R"
		elsif (86..94) === rnd
			green = "S"
		elsif rnd >= 95
			green = "F"
		end

		# scramble
		rnd = rand(0..100)
		if (0..19) === rnd
			scramble = "Y"
		elsif (20..34) === rnd
			scramble = "N"
		elsif (35..45) === rnd
			scramble = "BY"
		elsif (46..64) === rnd
			scramble = "BN"
		elsif rnd >= 65
			scramble = ""
		end

		# sand
		rnd = rand(0..100)
		if (0..10) === rnd
			sand = "Y"
		elsif (11..24) === rnd
			sand = "N"
		elsif rnd >= 25
			sand = ""
		end

		# create
		Hole.create!(:round_id => @round.id, :hole_number => h, :score_total => holescore, :score_total_esc => holescore, :putts => putts, :penalty => '', :fairway => fairway, :green => green, :sand => sand, :scramble => scramble, :holepar => holepararray[h], :holehandicap => @scorecard.hole1_handicap)
	end

	# update round with real score
	@round.score_total = @round.score_front + @round.score_back
	@round.score_total_adj = @round.score_total
	@round.handicap_differential = @round.score_total - @scorecard.rating
	@round.save
	puts @round.score_front
	puts @round.score_back
	puts @round.score_total
end