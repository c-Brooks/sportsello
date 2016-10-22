class Venue < ActiveRecord::Base

  geocoded_by :address
  after_validation :geocode

  has_many :can_hosts
  has_many :events, through: :can_hosts
  has_many :reviews


  validates :name, presence: true
  validates :website, presence: true
  validates :website, format: { with: URI.regexp }, if: 'website.present?'
end
