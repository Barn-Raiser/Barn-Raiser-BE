require 'rails_helper'

RSpec.describe 'Create a new supporter for a need', type: :request do
  describe 'happy path' do
    before :each do
      @need_1 = Need.create(title: "a need", description: "a test to see if we can test", point_of_contact: "test1@gmail.com", start_time: "2021-11-24 12:00", end_time: "2021-11-24 14:00", zip_code: "12345", supporters_needed: 12, status: "active")
      @need_2 = Need.create(title: "need 2", description: "the second test", point_of_contact: "test2@gmail.com", start_time: "2021-08-24 12:00", end_time: "2021-08-24 19:00", zip_code: "12345", supporters_needed: 4, status: "active")
      @need_3 = Need.create(title: "need 3", description: "the third test", point_of_contact: "test3@gmail.com", start_time: "2021-08-24 12:00", end_time: "2021-09-24 12:00", zip_code: "12345", supporters_needed: 1, status: "active")

      # Supporter 1 for need 1
      @query_1 =
              <<~GQL
                mutation {
                  createSupporter(input:
                    {
                    name: "Aliya"
                    email: "supporter@example.com"
                    needId: #{@need_1.id}
                  }
                  )
                  {
                  supporter {
                    id
                    name
                    email
                    needId
                  }
                  errors
                }
                }
              GQL

      # Supporter 2 for need 1
      @query_2 =
              <<~GQL
                mutation {
                  createSupporter(input:
                    {
                    name: "Andrew"
                    email: "supporter2@example.com"
                    needId: #{@need_1.id}
                  }
                  )
                  {
                  supporter {
                    id
                    name
                    email
                    needId
                  }
                  errors
                }
                }
              GQL

      # Supporter 1 for need 2
      @query_3 =
              <<~GQL
                mutation {
                  createSupporter(input:
                    {
                    name: "Aliya"
                    email: "supporter@example.com"
                    needId: #{@need_2.id}
                  }
                  )
                  {
                  supporter {
                    id
                    name
                    email
                    needId
                  }
                  errors
                }
                }
              GQL
    end

    it 'creates a new Supporter in the database if all required data is present' do
      post '/graphql', params: {query: @query_1}

      output = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(output[:data][:createSupporter][:supporter][:needId]).to eq(@need_1.id)

      expect(Supporter.last.need_id).to eq(@need_1.id)
      expect(Supporter.last.name).to eq("email")
      expect(Supporter.last.email).to eq("supporter@example.com")
    end

    it 'can have multiple supporters for a given need' do
      post '/graphql', params: {query: @query_1}
      post '/graphql', params: {query: @query_2}

      supporters = Supporter.where(need_id: @need_1.id)

      expect(supporters.length).to eq(2)
      expect(supporters.first.email).to eq("supporter@example.com")
      expect(supporters.last.email).to eq("supporter2@example.com")
    end
  end

  xdescribe 'sad path' do
    before :each do

      @incomplete_query =
              <<~GQL
                mutation {
                  createNeed(input:
                    {
                    title: "Cleanup our park"
                    description: "I've noticed a lot of litter in the park lately. I'd like to do a cleanup day with the community."
                    startTime: "2021-08-31 11:00:00 -600"
                    city: "Denver"
                    state: "Colorado"
                    zipCode: "80218"
                    supportersNeeded: 15
                    categories: [#{@cat_1.id}, #{@cat_3.id}]
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

    it 'returns an error if required data is missing' do
      post '/graphql', params: {query: @incomplete_query}
      output = JSON.parse(response.body, symbolize_names: true)

      expect(output[:need]).to eq(nil)
      expect(output[:errors].first[:message]).to eq("Argument 'pointOfContact' on InputObject 'CreateNeedInput' is required. Expected type String!")
      expect(output[:errors].second[:message]).to eq("Argument 'endTime' on InputObject 'CreateNeedInput' is required. Expected type String!")
    end
  end
end
