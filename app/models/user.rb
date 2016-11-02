class User < ActiveRecord::Base

  has_secure_password :validations => false

  has_many :reviews
  has_many :venues
  # Attends many events
  has_many :attendees
  before_save :downcase_email, if: 'email.present?'
  EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
  validates :name, :presence => true, :length => { :in => 3..20 }
  validates :email, :uniqueness => true, :format => EMAIL_REGEX, if: 'email.present?'
  validates :password, :confirmation => true, if: 'password.present?'
  validates_length_of :password, :in => 6..20, :on => :create, if: 'password.present?'

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def downcase_email
    email.downcase!
  end

end
