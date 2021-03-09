class Member < ApplicationRecord

  validates :name, length: (1..255)
  validates :url, length: (1..255), uniqueness: true, url: true
  validates :short_url, length: (0..255), allow_blank: true

  has_many :headings, dependent: :destroy

  has_many :friendships, dependent: :destroy
  
  def friends
    Members::FriendsQuery.call(member_id: id)
  end

  def total_friends
    # Would be better to store this as a counter cache but due to time constraints it's good for now
    friends.count
  end

  def is_friend?(friend_id)
    # Would be better to include the condition on the SQL but due to time constraints it's good for now
    friends.pluck(:id).include?(friend_id)
  end
  
end
