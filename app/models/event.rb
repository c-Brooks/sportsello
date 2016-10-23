class Event < ActiveRecord::Base
  has_many :can_hosts
  has_many :venues, through: :can_hosts
  has_one :game
end
