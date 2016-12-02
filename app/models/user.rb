class User < ActiveRecord::Base
  has_secure_password
	before_save { self.email = self.email.downcase }
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGAX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGAX },
                    uniqueness: {case_sensitive: false }
end
