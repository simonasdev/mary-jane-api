class RecordSerializer < ActiveModel::Serializer
  attributes :id, :amount, :high, :user_id
end