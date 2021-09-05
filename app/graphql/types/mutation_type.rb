module Types
  class MutationType < Types::BaseObject
    field :create_need, mutation: Mutations::CreateNeed
    field :create_supporter, mutation: Mutations::CreateSupporter
  end
end
