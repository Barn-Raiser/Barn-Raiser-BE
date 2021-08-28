module Types
  class NeedType < Types::BaseObject
    field :id, ID, null: false
    field :point_of_contact, String, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :start_time, String, null: false
    field :end_time, String, null: false
    field :street_address, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :zip_code, String, null: false
    field :supporters_needed, Integer, null: false
    field :status, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
