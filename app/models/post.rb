class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 150 }
  
  has_attached_file :picture 
  validates :picture, presence: true
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/ 
  validates_attachment_size :picture, less_than: 2.megabytes
end
