class User < ActiveRecord::Base
  has_secure_password
	before_save { self.email = self.email.downcase }
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGAX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGAX },
                    uniqueness: {case_sensitive: false }
  has_many :microposts
  validates :location, length: { maximum: 25 } , presence: true
  
  has_many :following_relationships, class_name: "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :follower_relationships, source: :follower

  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end
  
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  def following?(other_user)
  following_users.include?(other_user)
  end
  
   has_many :follower_relationships, class_name: "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
   has_many :follower_users, through: :follower_relationships, source: :followers
   
   def follower(other_user)
     follower_relationships.find_or_create_by(followed_id: other_user.id)
     follower_relationship.destroy if follower_relationship
   end
   
   def follower?(other_user)
   follower_users.include?(other_user)
   end
end

