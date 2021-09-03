class Types::CategoryType < Types::BaseObject
  field :id, ID, null: false
  field :tag, String, null: false
  field :needs, [Types::NeedType], null:false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
end
