require 'rails_helper'

RSpec.describe 'Create a new need', type: :request do
  describe 'happy path' do
    before :each do
      @query =
              <<~GQL
                mutation {
                  createNeed(input:
                    {
                    title: "Cleanup our park"
                    pointOfContact: "test@example.com"
                    description: "I've noticed a lot of litter in the park lately. I'd like to do a cleanup day with the community."
                    startTime: "2021-08-31 11:00:00 -600"
                    endTime: "2021-08-31 12:00:00 -600"
                    city: "Denver"
                    state: "Colorado"
                    zipCode: "80218"
                    supportersNeeded: 15
                  }
                  )
                  {
                  need {
                    id
                    title
                  }
                  errors
                }
                }
              GQL
    end

    it 'creates a new Need in the database if all required data is present' do
      post '/graphql', params: {query: @query}

      output = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(output[:data][:createNeed][:need]).to_not eq(nil)
      expect(output[:data][:createNeed][:need][:title]).to eq("Cleanup our park")

      expect(Need.last.id).to eq(output[:data][:createNeed][:need][:id].to_i)
      expect(Need.last.point_of_contact).to eq("test@example.com")
      expect(Need.last.supporters_needed).to eq(15)
      expect(Need.last.title).to eq("Cleanup our park")
      expect(Need.last.street_address).to eq(nil)
    end

    xit 'sets status to active in create' do
      post '/graphql', params: @body, as: :json

      expect(Need.last.status).to eq('active')
    end

  end

  xdescribe 'sad path' do
    it 'returns an error if required data is missing' do
      incomplete_body = "mutation {
                createNeed(input:
                  	     {
                 	          title: `Cleanup our park`
                            description: `I've noticed a lot of litter in the park lately. I'd like to do a cleanup day with the community.`
                            startTime: `2021-08-31 11:00:00 -600`
                            city: `Denver`
                            state: `Colorado`
                            zipCode: `80218`
                            supportersNeeded: 15
                          }
                          )
                {
                  need {
                        id
                      }
                  errors
              	}
              }"

      post '/graphql', params: @body, as: :json
      output = JSON.parse(response.body, symbolize_names: true)

      expect(output[:errors].first).to eq("point_of_contact cannot be blank")
    end
  end
end
