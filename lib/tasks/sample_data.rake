namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_rounds
  end
end

def make_rounds
  
end