class RecordSerializer < ActiveModel::Serializer
  self.root = false

  attributes :id, :amount, :high, :user_id
end