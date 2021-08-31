class Mutations::CreateNeed < Mutations::BaseMutation
  argument :title, String, required: true
  argument :point_of_contact, String, required: true
  argument :description, String, required: true
  argument :start_time, String, required: true
  argument :end_time, String, required: true
  argument :street_address, String, required: false
  argument :city, String, required: false
  argument :state, String, required: false
  argument :zip_code, String, required: true
  argument :supporters_needed, Integer, required: true

  field :need, Types::NeedType, null: true
  field :errors, [String], null: false

  def resolve(title:, point_of_contact:, description:, start_time:, end_time:, street_address: nil, city: nil, state: nil, zip_code:, supporters_needed:)
    need = Need.new(
            title: title,
            point_of_contact: point_of_contact,
            description: description,
            start_time: start_time,
            end_time: end_time,
            street_address: street_address,
            city: city,
            state: state,
            zip_code: zip_code,
            supporters_needed: supporters_needed,
            status: 0
            )

    if need.save
      {
        need: need,
        errors: []
      }
    else
      {
        need: nil,
        errors: need.errors.full_messages
      }
    end
  end
end
