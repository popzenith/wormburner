puts 'SETTING UP MASTER USER LOGIN'
user = User.create! :name => 'J.L. Novosad', :email => 'test1@golfpals.co', :password => 'foobar', :password_confirmation => 'foobar'
puts 'New user created: ' << user.name
user.add_role :admin

puts 'SETTING UP MASTER USER LOGIN'
user = User.create! :name => 'Mr. Popular', :email => 'golfpals@popzenith.com', :password => 'foobar', :password_confirmation => 'foobar'
puts 'New user created: ' << user.name
user.add_role :admin