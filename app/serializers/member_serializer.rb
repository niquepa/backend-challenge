class MemberSerializer < ActiveModel::Serializer
  attributes :id, :name, :short_url, :url
  has_many :headings
  has_many :friends
end
