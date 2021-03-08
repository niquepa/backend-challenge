class FriendshipSerializer < ActiveModel::Serializer
  attributes :id
  has_one :member
  has_one :friend
end
