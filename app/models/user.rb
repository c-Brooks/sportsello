class User < ActiveRecord::Base
  has_many :review

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true

  validates_uniqueness_of :email, case_sensitive: false
  validates_confirmation_of :password, message: 'should match confirmation'
end
