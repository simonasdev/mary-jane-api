class UserSerializer < ActiveModel::Serializer
  self.root = false

  attributes :id, :name, :photo
end