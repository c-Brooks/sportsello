class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  before_save :downcase_email
  EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
  validates :name, :presence => true, :length => { :in => 3..20 }
  validates :email, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true
  validates_length_of :password, :in => 6..20, :on => :create

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

end
