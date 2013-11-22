puts 'SETTING UP USERS'
user = User.create! :name => 'J.L. Novosad', :email => 'test1@golfpals.co', :password => 'foobar', :password_confirmation => 'foobar'
puts 'New user created: ' << user.name
user.add_role :admin

user = User.create! :name => "Al Theman", :email => "test2@golfpals.co", :password => "foobar", :password_confirmation => "foobar"
user.microposts.create!(content: "Killing it")
user.microposts.create!(content: "The price is reasonable")
user.follow!(User.find_by_name("J.L. Novosad"), "FRIENDS")

user = User.create! :name => "Jake Trout", :email => "test3@golfpals.co", :password => "foobar", :password_confirmation => "foobar"
user.microposts.create!(content: "Are we doing this?")
user.microposts.create!(content: "Say hi to Jimmy, the manager")
user.follow!(User.find_by_name("J.L. Novosad"), "FRIENDS")

user = User.create! :name => "Sandeee", :email => "test4@golfpals.co", :password => "foobar", :password_confirmation => "foobar"
user.microposts.create!(content: "most of the fairways and greens were well taken care of and the design of the course had a good combination of interesting and challenging holes as well as some more straight forward ones.")
user.microposts.create!(content: "woooooooooooo")
user.follow!(User.find_by_name("J.L. Novosad"), "FRIENDS")

user = User.create! :name => "Kima O'Connor", :email => "test5@golfpals.co", :password => "foobar", :password_confirmation => "foobar"
user.microposts.create!(content: "Gooooooose")
user.microposts.create!(content: "Check out the porch bar")
user.follow!(User.find_by_name("J.L. Novosad"), "FRIENDS")

user = User.create! :name => "Allie Smith", :email => "test6@golfpals.co", :password => "foobar", :password_confirmation => "foobar"
user.follow!(User.find_by_name("J.L. Novosad"), "FRIENDS")

user = User.create! :name => "Mr. Popular", :email => "golfpals@popzenith.com", :password => "foobar", :password_confirmation => "foobar"
user.follow!(User.find_by_name("Al Theman"), "FRIENDS")