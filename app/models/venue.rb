class Venue < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode

  has_many :events, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :website, presence: true
  validates :website, format: { with: URI.regexp }, if: 'website.present?'
end
