class Friendship < ApplicationRecord

  validate :check_if_is_already_a_friend

  belongs_to :member
  belongs_to :friend, class_name: 'Member'

  def check_if_is_already_a_friend
    if member.is_friend?(friend.id)
      errors.add(:friend, "It's already a Friend")
    end
  end
end
