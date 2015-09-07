class User < ActiveRecord::Base
  
  has_secure_password
  
  validates :name, presence: true, length: {minimum: 3, maximum: 75},
                   uniqueness: { case_sensitive: false }
                   
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  validates :password, presence: true, length: { minimum: 5, maximum: 40}

end
