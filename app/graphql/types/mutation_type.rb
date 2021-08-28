module Types
  class MutationType < Types::BaseObject
    field :create_need, mutation: Mutations::CreateNeed
  end
end
