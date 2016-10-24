class Event < ActiveRecord::Base
  belongs_to :venues
  has_one :game
end
