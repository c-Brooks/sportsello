class Review < ActiveRecord::Base
  belongs_to :venue
  belongs_to :user

  validates :rating, presence: true, numericality: { only_integer: true }

end
