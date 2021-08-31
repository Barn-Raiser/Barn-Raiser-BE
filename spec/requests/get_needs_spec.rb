require 'rails_helper'

RSpec.describe 'get info on need', type: :request do
  describe 'allNeeds' do
    it 'can return all information' do
      need = Need.create(title: "a need", description: "a test to see if we can test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 12, status: "active")
      need = Need.create(title: "need 2", description: "the second test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 4, status: "active")
      need = Need.create(title: "need 3", description: "the theird test", point_of_contact: "test@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 1, status: "active")

      query = <<~GQL
              { allNeeds
                {
                  title
                  description
                  pointOfContact
                  startTime
                  endTime
                  zipCode
                  supportersNeeded
                  status
                }
              }
              GQL

      post '/graphql', params: {query: query}

      needs = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")

      expect(needs[:data][:allNeeds]).to be_a(Array)
      expect(needs[:data][:allNeeds].count).to eq(3)

      expect(needs[:data][:allNeeds].first[:title]).to eq("a need")
      expect(needs[:data][:allNeeds].first[:description]).to eq("a test to see if we can test")
      expect(needs[:data][:allNeeds].first[:pointOfContact]).to eq("email@gmail.com")
      expect(needs[:data][:allNeeds].first[:startTime]).to eq("string value")
      expect(needs[:data][:allNeeds].first[:endTime]).to eq("string value")
      expect(needs[:data][:allNeeds].first[:zipCode]).to eq("12345")
      expect(needs[:data][:allNeeds].first[:supportersNeeded]).to eq(12)
      expect(needs[:data][:allNeeds].first[:status]).to eq("active")
    end
  end
