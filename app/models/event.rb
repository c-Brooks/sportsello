class Event < ActiveRecord::Base
  has_one :venue
  has_one :game
end
