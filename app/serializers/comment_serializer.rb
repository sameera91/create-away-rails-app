class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user
  has_one :project
  has_one :user
end
