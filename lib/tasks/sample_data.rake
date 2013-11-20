
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_relationships
    make_popular
    make_microposts
  end
end

def make_users
  10.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@golfpals.co"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
  89.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+11}@golfpals.co"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[2..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_popular
  users = User.all
  user  = users[2]
  followed_users = users[3..4]
  followed_users.each { |followed| user.follow!(followed) }
end

def make_microposts
  users = User.all(limit: 50)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end
