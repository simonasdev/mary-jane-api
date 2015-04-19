require_relative 'short_user_serializer'

class RecordSerializer < ActiveModel::Serializer
  attributes :id, :amount, :high

  has_one :user, serializer: ShortUserSerializer
end