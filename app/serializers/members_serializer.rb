class MembersSerializer < ActiveModel::Serializer
  attributes :id, :name, :short_url, :total_friends
end
