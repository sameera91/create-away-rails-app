class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :short_blurb, :likes
  has_one :user
end
