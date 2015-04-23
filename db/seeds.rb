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

user = User.create! :name => 'jlnovosad', :email => 'jlnovosad@gmail.com', :password => 'foobar', :password_confirmation => 'foobar', :gender => 'M', :buddy => 'REAL'
user.add_role :admin
user = User.create! :name => 'art', :email => 'art@wb.co', :password => 'foobar', :password_confirmation => 'foobar', :gender => 'F', :buddy => 'REAL'
