require 'date'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding Data ..."

# Helper functions
# def open_asset(file_name)
#   File.open(Rails.root.join('db', 'seed_assets', file_name))
# end

# Only run on development (local) instances not on production, etc.
raise "Development seeds only (for now)!" unless Rails.env.development?

# Setup users...
User.destroy_all

user = User.create!({
  provider: 'facebook',
  uid: 10202288529331229,
  name: 'Corey Brooks',
  oauth_token: 'EAADzQ4vKSEgBADtIN8mT8d5D5lGZAZChZAc60ZCPT63mPru24ZBTQ4zklkqingfqQYMnZBTKEJh5FuuFTYg4uH7dNwACDZAK4OHPkXJ1ZALW6UZC7b3WYXCeSZAa5r7mLRlEk4HK5tI5vZBXGRJbtqStPHRO0P4uFqVaVsZD',
})

# Setup venues...
Venue.destroy_all

venue1 = Venue.create!({
  name: 'Lighthouse',
  website: 'https://www.lighthouselabs.ca/?gclid=CjwKEAjw-abABRDquOTJi8qdojwSJABt1S1ONBGfRHFbKdKdEdWPwj6GkAMjhkXtv2qW3SbljLtAJBoCyBjw_wcB',
  description: 'A cool bar with cool people looking to sit back and cool.',
  longitude: 123.1058901,
  latitude: 49.2831424,
  address: '12 Powell St, Vancouver, BC'
})

venue2 = Venue.create!({
  name: 'Moms Basement',
  website: 'https://spencertranter.github.io',
  description: 'Stay away',
  longitude: 123.1451002,
  latitude: 49.2911695,
  address: '1885 Barclay St, Vancouver, BC'
})

venue3 = Venue.create!({
  name: 'Middle Earth',
  website: 'http://lotrproject.com/map/',
  description: 'Vegans only.',
  longitude: 123.1237845,
  latitude: 49.2841426,
  address: '701 W Georgia St, Vancouver'
})

# Setup sports...
Sport.destroy_all

sport1 = Sport.create!({
  name: 'NHL'
})

sport2 = Sport.create!({
  name: 'MLB'
})

sport3 = Sport.create!({
  name: 'NBA'
})

# Setup teams...
Team.destroy_all

Team.create!({
  name: 'SKT'
})

Team.create!({
  name: 'H2K'
})

Team.create!({
  name: 'EDG'
})

Team.create!({
  name: 'TSM'
})

# Setup games...
Game.destroy_all

game1 = Game.create!({
  sport_id: sport1.id,
  team1_id: 1,
  team2_id: 2,
  game_datetime: DateTime.now
})

game2 = Game.create!({
  sport_id: sport2.id,
  team1_id: 3,
  team2_id: 4,
  game_datetime: DateTime.now + 1
})

game3 = Game.create!({
  sport_id: sport3.id,
  team1_id: 3,
  team2_id: 4,
  game_datetime: DateTime.now + 2
})

game4 = Game.create!({
  sport_id: sport1.id,
  team1_id: 1,
  team2_id: 4,
  game_datetime: DateTime.now + 3
})


# Setup events...
Event.destroy_all

venue1.events.create!({
  name: 'Spring Split',
  game_id: game1.id
})

venue1.events.create!({
  name: 'LCS',
  game_id: game2.id
})

venue2.events.create!({
  name: 'Mid Season Invitational',
  game_id: game1.id
})

venue3.events.create!({
  name: 'Friyay',
  game_id: game3.id
})

venue3.events.create!({
  name: 'Wet T-Shirt Contests + Sports',
  game_id: game4.id
})

# Setup reviews...
Review.destroy_all

Review.create!({
  venue: venue1,
  user: user,
  description: 'I like turtles.',
  rating: 4
})

Review.create!({
  venue: venue1,
  user: user,
  description: 'The sorbe at this place is middle class shit.',
  rating: 3
})

Review.create!({
  venue: venue2,
  user: user,
  description: 'Human garbage.',
  rating: 2
})

Review.create!({
  venue: venue3,
  user: user,
  description: 'The tv here is a toaster.',
  rating: 1
})

puts 'DONE!'
