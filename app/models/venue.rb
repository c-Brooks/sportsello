class Venue < ActiveRecord::Base
  has_many :reviews
  has_many :events

  validates :name, presence: true
  validates :website, presence: true
  validates :website, format: { with: URI.regexp }, if: 'url.present?'
end
