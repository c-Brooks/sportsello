class Event < ActiveRecord::Base
  has_many :can_hosts
  has_many :venues, through: :can_hosts
  belongs_to :sport

  validates :name, presence: true

end
