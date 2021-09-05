class Mutations::CreateSupporter < Mutations::BaseMutation
  argument :name, String, required: true
  argument :email, String, required: true
  argument :need, ID, required: true

  field :supporter, Types::SupporterType, null: true
  field :errors, [String], null: false

  def resolve(name:, email:, need:)
    supporter = Supporter.new(
              name: name,
              email: email,
              need_id: need
              )

    if supporter.save
      {
        supporter: supporter,
        errors: []
      }
    else
      {
        errors: supporter.errors.full_messsages
      }
    end
  end
end
