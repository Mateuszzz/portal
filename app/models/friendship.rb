class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"
  
  validates :friend_id, presence: true, uniqueness: {scope: :user_id}
  validates_inclusion_of :accepted, :in => [true, false]
  
  validate :check_user_id_and_friend_id

  def check_user_id_and_friend_id
    
    if self.user_id == self.friend_id
      errors.add(:user_id, "can't equal friend_id")
      errors.add(:friend_id, "can't equal user_id")
    end
  end
  
  def self.check_friendships(user, friend)
    where("friend_id IN (?) AND user_id IN (?)", [user, friend], [user, friend] )
  end
  
  def self.return_friendship(friend, user)
    where("friend_id = ? AND user_id = ?", friend, user ).first
  end
end
