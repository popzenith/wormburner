puts 'SETTING UP'

require 'csv'  

csv = CSV.read('db/d_facilities.csv', :headers => true, :encoding => 'iso-8859-1:utf-8')
csv.each do |row|
Facility.create!(:facility_code => row['facility_code'], :facility_name => row['facility_name'], :club_membership => row['club_membership'], :number_of_holes => row['number_of_holes'], :address => row['address'], :city => row['city'], :state => row['state'], :country => row['country'], :postal_code => row['postal_code'], :phone => row['phone'], :fax => row['fax'], :website => row['website'], :longitude => row['longitude'], :latitude => row['latitude'], :contact_name => row['contact_name'], :contact_title => row['contact_title'], :email_address => row['email_address'], :driving_range => row['driving_range'], :putting_green => row['putting_green'], :chipping_green => row['chipping_green'], :practice_bunker => row['practice_bunker'], :motor_cart => row['motor_cart'], :pull_cart => row['pull_cart'], :golf_clubs_rental => row['golf_clubs_rental'], :club_fitting => row['club_fitting'], :pro_shop => row['pro_shop'], :golf_lessons => row['golf_lessons'], :caddie_hire => row['caddie_hire'], :restaurant => row['restaurant'], :reception_hall => row['reception_hall'], :changing_room => row['changing_room'], :lockers => row['lockers'], :lodging_on_site => row['lodging_on_site'])
end

csv = CSV.read('db/d_courses.csv', :headers => true, :encoding => 'iso-8859-1:utf-8')
csv.each do |row|
fid = Facility.find_by_facility_code(row['facility_code'])
if fid.nil?
else
Course.create!(:facility_id => fid.id, :course_code => row['course_code'], :facility_code => row['facility_code'], :course_name => row['course_name'], :par => row['par'], :course_type => row['course_type'], :course_architect => row['course_architect'], :open_date => row['open_date'], :guest_policy => row['guest_policy'], :weekday_price => row['weekday_price'], :weekend_price => row['weekend_price'], :twilight_price => row['twilight_price'], :fairway => row['fairway'], :green => row['green'], :currency => row['currency'], :hol => row['hol'])
end
end

csv = CSV.read('db/d_scorecards.csv', :headers => true, :encoding => 'iso-8859-1:utf-8')
csv.each do |row|
cid = Course.find_by_course_code(row['course_code'])
if cid.nil?
else
Scorecard.create!(:course_id => cid.id, :tee_id => row['tee_id'], :course_code => row['course_code'], :tee_name => row['tee_name'], :tee_color => row['tee_color'], :course_par_for_tee => row['course_par_for_tee'], :hole1 => row['hole1'], :hole2 => row['hole2'], :hole3 => row['hole3'], :hole4 => row['hole4'], :hole5 => row['hole5'], :hole6 => row['hole6'], :hole7 => row['hole7'], :hole8 => row['hole8'], :hole9 => row['hole9'], :hole10 => row['hole10'], :hole11 => row['hole11'], :hole12 => row['hole12'], :hole13 => row['hole13'], :hole14 => row['hole14'], :hole15 => row['hole15'], :hole16 => row['hole16'], :hole17 => row['hole17'], :hole18 => row['hole18'], :total_distance => row['total_distance'], :hole1_par => row['hole1_par'], :hole2_par => row['hole2_par'], :hole3_par => row['hole3_par'], :hole4_par => row['hole4_par'], :hole5_par => row['hole5_par'], :hole6_par => row['hole6_par'], :hole7_par => row['hole7_par'], :hole8_par => row['hole8_par'], :hole9_par => row['hole9_par'], :hole10_par => row['hole10_par'], :hole11_par => row['hole11_par'], :hole12_par => row['hole12_par'], :hole13_par => row['hole13_par'], :hole14_par => row['hole14_par'], :hole15_par => row['hole15_par'], :hole16_par => row['hole16_par'], :hole17_par => row['hole17_par'], :hole18_par => row['hole18_par'], :hole1_handicap => row['hole1_handicap'], :hole2_handicap => row['hole2_handicap'], :hole3_handicap => row['hole3_handicap'], :hole4_handicap => row['hole4_handicap'], :hole5_handicap => row['hole5_handicap'], :hole6_handicap => row['hole6_handicap'], :hole7_handicap => row['hole7_handicap'], :hole8_handicap => row['hole8_handicap'], :hole9_handicap => row['hole9_handicap'], :hole10_handicap => row['hole10_handicap'], :hole11_handicap => row['hole11_handicap'], :hole12_handicap => row['hole12_handicap'], :hole13_handicap => row['hole13_handicap'], :hole14_handicap => row['hole14_handicap'], :hole15_handicap => row['hole15_handicap'], :hole16_handicap => row['hole16_handicap'], :hole17_handicap => row['hole17_handicap'], :hole18_handicap => row['hole18_handicap'], :rating => row['rating'], :slope => row['slope'])
end
end

user = User.create! :name => 'jlnovosad', :email => 'test1@wb.co', :password => 'foobar', :password_confirmation => 'foobar', :gender => 'M', :buddy => 'REAL'
user.add_role :admin
user = User.create! :name => 'art', :email => 'art@wb.co', :password => 'foobar', :password_confirmation => 'foobar', :gender => 'F', :buddy => 'REAL'
