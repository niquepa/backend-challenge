class ExpertsSerializer < ActiveModel::Serializer
  attributes :id, :name, :short_url, :friend, :text
end
