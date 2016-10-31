class Event < ActiveRecord::Base
  belongs_to :venue
  has_one :game
  has_many :attendees
end
