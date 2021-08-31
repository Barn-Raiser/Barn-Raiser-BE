require 'rails_helper'

RSpec.describe 'get info on need', type: :request do
  describe 'find list of needs' do
    describe 'allNeeds' do
      it 'can return all information' do
        need_1 = Need.create(title: "a need", description: "a test to see if we can test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 12, status: "active")
        need_2 = Need.create(title: "need 2", description: "the second test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 4, status: "active")
        need_3 = Need.create(title: "need 3", description: "the theird test", point_of_contact: "test@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 1, status: "active")

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

    # describe 'allActiveNeeds' do
    #   it 'can return all information' do
    #     need_1 = Need.create(title: "need_1", description: "first", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 12, status: "active")
    #     need_2 = Need.create(title: "need 2", description: "the second test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 4, status: "rejected")
    #     need_3 = Need.create(title: "need 3", description: "the theird test", point_of_contact: "test@gmail.com", start_time: "string value", end_time: "string value", zip_code: "54321", supporters_needed: 1, status: "active")
    #     need_4 = Need.create(title: "need 4", description: "the fourth test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "24680", supporters_needed: 3, status: "active")
    #     need_5 = Need.create(title: "need 5", description: "the fifth test", point_of_contact: "asdf@adsf.asdf", start_time: "string value", end_time: "string value", zip_code: "54321", supporters_needed: 5, status: "rejected")
    #
    #     query = <<~GQL
    #             { allActiveNeeds
    #               {
    #                 title
    #                 description
    #                 pointOfContact
    #                 startTime
    #                 endTime
    #                 zipCode
    #                 supportersNeeded
    #                 status
    #               }
    #             }
    #             GQL
    #
    #     post '/graphql', params: {query: query}
    #
    #     needs = JSON.parse(response.body, symbolize_names: true)
    #
    #     expect(response).to be_successful
    #     expect(response.status).to eq(200)
    #     expect(response.content_type).to eq("application/json")
    #
    #     expect(needs[:data][:allActiveNeeds]).to be_a(Array)
    #     expect(needs[:data][:allActiveNeeds].count).to eq(3)
    #
    #     expect(needs[:data][:allActiveNeeds].first[:title]).to eq("need_1")
    #     expect(needs[:data][:allActiveNeeds].first[:description]).to eq("a test to see if we can test")
    #     expect(needs[:data][:allActiveNeeds].first[:pointOfContact]).to eq("email@gmail.com")
    #     expect(needs[:data][:allActiveNeeds].first[:startTime]).to eq("string value")
    #     expect(needs[:data][:allActiveNeeds].first[:endTime]).to eq("string value")
    #     expect(needs[:data][:allActiveNeeds].first[:zipCode]).to eq("12345")
    #     expect(needs[:data][:allActiveNeeds].first[:supportersNeeded]).to eq(12)
    #     expect(needs[:data][:allActiveNeeds].first[:status]).to eq("active")
    #   end
    # end
  end

  describe 'find one need' do
    describe 'need(id:)' do
      it ' can returns all possible data' do
        need_2 = Need.create(title: "need 2", description: "the second test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 4, status: "active")
        need_1 = Need.create(title: "a need", description: "a test to see if we can test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 12, status: "active")
        need_3 = Need.create(title: "need 3", description: "the theird test", point_of_contact: "test@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 1, status: "active")

        query = <<~GQL
                  { need(id:#{need_1.id})
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

        expect(needs[:data][:need]).to have_key(:title)
        expect(needs[:data][:need][:title]).to eq("a need")
        expect(needs[:data][:need]).to have_key(:description)
        expect(needs[:data][:need][:description]).to eq("a test to see if we can test")
        expect(needs[:data][:need]).to have_key(:pointOfContact)
        expect(needs[:data][:need][:pointOfContact]).to eq("email@gmail.com")
        expect(needs[:data][:need]).to have_key(:startTime)
        expect(needs[:data][:need][:startTime]).to eq("string value")
        expect(needs[:data][:need]).to have_key(:endTime)
        expect(needs[:data][:need][:endTime]).to eq("string value")
        expect(needs[:data][:need]).to have_key(:zipCode)
        expect(needs[:data][:need][:zipCode]).to eq("12345")
        expect(needs[:data][:need]).to have_key(:supportersNeeded)
        expect(needs[:data][:need][:supportersNeeded]).to eq(12)
        expect(needs[:data][:need]).to have_key(:status)
        expect(needs[:data][:need][:status]).to eq("active")
      end

      it 'can return only one requested piece of data ' do
        need_2 = Need.create(title: "need 2", description: "the second test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 4, status: "active")
        need_1 = Need.create(title: "a need", description: "a test to see if we can test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 12, status: "active")
        need_3 = Need.create(title: "need 3", description: "the theird test", point_of_contact: "test@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 1, status: "active")

        query = <<~GQL
                  { need(id:#{need_1.id})
                    {
                      title
                    }
                  }
                  GQL

        post '/graphql', params: {query: query}

        needs = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")

        expect(needs[:data][:need]).to have_key(:title)
        expect(needs[:data][:need][:title]).to eq("a need")
        expect(needs[:data][:need]).to_not have_key(:description)
        expect(needs[:data][:need][:description]).to eq(nil)
        expect(needs[:data][:need]).to_not have_key(:pointOfContact)
        expect(needs[:data][:need][:pointOfContact]).to eq(nil)
        expect(needs[:data][:need]).to_not have_key(:startTime)
        expect(needs[:data][:need][:startTime]).to eq(nil)
        expect(needs[:data][:need]).to_not have_key(:endTime)
        expect(needs[:data][:need][:endTime]).to eq(nil)
        expect(needs[:data][:need]).to_not have_key(:zipCode)
        expect(needs[:data][:need][:zipCode]).to eq(nil)
        expect(needs[:data][:need]).to_not have_key(:supportersNeeded)
        expect(needs[:data][:need][:supportersNeeded]).to eq(nil)
        expect(needs[:data][:need]).to_not have_key(:status)
        expect(needs[:data][:need][:status]).to eq(nil)
      end

    end
  end
end
