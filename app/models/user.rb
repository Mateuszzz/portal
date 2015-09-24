class User < ActiveRecord::Base
  attr_accessor :remove_avatar
  has_many :posts, dependent: :destroy
  has_secure_password
  
  validates :name, presence: true, length: {minimum: 3, maximum: 75},
                   uniqueness: { case_sensitive: false }
                   
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  validates :password, presence: true, length: { minimum: 5, maximum: 40}
  
  has_attached_file :avatar
  validates :avatar, presence:false
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/ 
  validates_attachment_size :avatar, less_than: 512.kilobytes
  
  def self.search(query)
    where("name like ?", "%#{query}%") 
  end
end
