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
                    need: #{@need_1.id}
                  }
                  )
                  {
                  supporter {
                    id
                    name
                    email
                    need  {
                      id
                      title
                      pointOfContact
                      categories
                        {tag}
                    }
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
                    need: #{@need_1.id}
                  }
                  )
                  {
                  supporter {
                    id
                    name
                    email
                    need  {
                      id
                      title
                      pointOfContact
                      categories
                        {tag}
                    }
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
                  name: "Andrew"
                  email: "supporter2@example.com"
                  need: #{@need_2.id}
                }
                )
                {
                supporter {
                  id
                  name
                  email
                  need  {
                    id
                    title
                    pointOfContact
                    categories
                      {tag}
                  }
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
      expect(output[:data][:createSupporter][:supporter][:need][:id].to_i).to eq(@need_1.id)

      expect(Supporter.last.need_id).to eq(@need_1.id)
      expect(Supporter.last.name).to eq("Aliya")
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

  describe 'sad path' do
    before :each do
      @need_1 = Need.create(title: "a need", description: "a test to see if we can test", point_of_contact: "test1@gmail.com", start_time: "2021-11-24 12:00", end_time: "2021-11-24 14:00", zip_code: "12345", supporters_needed: 12, status: "active")

      @incomplete_query =
          <<~GQL
            mutation {
              createSupporter(input:
                {
                name: "Andrew"
                need: #{@need_1.id}
              }
              )
              {
              supporter {
                id
                name
                email
                need  {
                  id
                  title
                  pointOfContact
                  categories
                    {tag}
                }
              }
              errors
            }
            }
          GQL
    end

    it 'returns an error if required data is missing' do
      post '/graphql', params: {query: @incomplete_query}
      output = JSON.parse(response.body, symbolize_names: true)

      expect(output[:supporter]).to eq(nil)
      expect(output[:errors].first[:message]).to eq("Argument 'email' on InputObject 'CreateSupporterInput' is required. Expected type String!")
    end
  end
end
