module Types
  class QueryType < Types::BaseObject
    # Set up + define field for all active needs query
    field :allActiveNeeds, [Types::NeedType], null: false
    def allActiveNeeds
      Need.where(status: 'active')
    end

    # Set up + define field for all  needs query
    field :allNeeds, [Types::NeedType], null: false

    def allNeeds
      Need.all
    end

    # Set up + define field for retrieving a single need by id
    field :need, Types::NeedType, null: false do
      argument :id, ID, required: true
    end

    def need(id:)
      Need.find(id)
    end

    # Set up + define field for all categories query
    field :allCategories, [Types::CategoryType], null: false
    def allCategories
      Category.all
    end


  end
end
