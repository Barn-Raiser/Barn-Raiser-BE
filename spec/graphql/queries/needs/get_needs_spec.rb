require 'rails_helper'

RSpec.describe 'get info on need', type: :request do
  describe 'find list of needs' do
    describe 'allNeeds' do
      it 'can return all information' do
        need_1 = Need.create(title: "a need", description: "a test to see if we can test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 12, status: "active")
        need_2 = Need.create(title: "need 2", description: "the second test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 4, status: "active")
        need_3 = Need.create(title: "need 3", description: "the theird test", point_of_contact: "test@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 1, status: "active")

        cat_1 = Category.create!(tag: "Food")
        cat_2 = Category.create!(tag: "Manual Labor")
        cat_3 = Category.create!(tag: "Cleanup")

        NeedCategory.create!(need_id: need_1.id, category_id: cat_1.id)
        NeedCategory.create!(need_id: need_1.id, category_id: cat_2.id)
        NeedCategory.create!(need_id: need_2.id, category_id: cat_2.id)
        NeedCategory.create!(need_id: need_3.id, category_id: cat_3.id)

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
                    categories {
                      id
                      tag
                    }
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
        expect(needs[:data][:allNeeds].first[:categories].first[:tag]).to eq(cat_1.tag)
        expect(needs[:data][:allNeeds].first[:categories].last[:tag]).to eq(cat_2.tag)

        expect(needs[:data][:allNeeds].last[:title]).to eq("need 3")
        expect(needs[:data][:allNeeds].last[:description]).to eq("the theird test")
        expect(needs[:data][:allNeeds].last[:pointOfContact]).to eq("test@gmail.com")
        expect(needs[:data][:allNeeds].last[:startTime]).to eq("string value")
        expect(needs[:data][:allNeeds].last[:endTime]).to eq("string value")
        expect(needs[:data][:allNeeds].last[:zipCode]).to eq("12345")
        expect(needs[:data][:allNeeds].last[:supportersNeeded]).to eq(1)
        expect(needs[:data][:allNeeds].last[:status]).to eq("active")
        expect(needs[:data][:allNeeds].last[:categories].first[:tag]).to eq(cat_3.tag)
      end

      it 'can return limited information if requested' do
        need_1 = Need.create(title: "a need", description: "a test to see if we can test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 12, status: "active")
        need_2 = Need.create(title: "need 2", description: "the second test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 4, status: "active")
        need_3 = Need.create(title: "need 3", description: "the theird test", point_of_contact: "test@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 1, status: "active")

        cat_1 = Category.create!(tag: "Food")
        cat_2 = Category.create!(tag: "Manual Labor")
        cat_3 = Category.create!(tag: "Cleanup")

        NeedCategory.create!(need_id: need_1.id, category_id: cat_1.id)
        NeedCategory.create!(need_id: need_1.id, category_id: cat_2.id)
        NeedCategory.create!(need_id: need_2.id, category_id: cat_2.id)
        NeedCategory.create!(need_id: need_3.id, category_id: cat_3.id)
        query = <<~GQL
                { allNeeds
                  {
                    title
                    pointOfContact
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
        expect(needs[:data][:allNeeds].first[:description]).to_not eq("a test to see if we can test")
        expect(needs[:data][:allNeeds].first[:pointOfContact]).to eq("email@gmail.com")
        expect(needs[:data][:allNeeds].first[:startTime]).to_not eq("string value")
        expect(needs[:data][:allNeeds].first[:endTime]).to_not eq("string value")
        expect(needs[:data][:allNeeds].first[:zipCode]).to_not eq("12345")
        expect(needs[:data][:allNeeds].first[:supportersNeeded]).to_not eq(12)
        expect(needs[:data][:allNeeds].first[:status]).to_not eq("active")

        expect(needs[:data][:allNeeds].last[:title]).to eq("need 3")
        expect(needs[:data][:allNeeds].last[:description]).to_not eq("the theird test")
        expect(needs[:data][:allNeeds].last[:pointOfContact]).to eq("test@gmail.com")
        expect(needs[:data][:allNeeds].last[:startTime]).to_not eq("string value")
        expect(needs[:data][:allNeeds].last[:endTime]).to_not eq("string value")
        expect(needs[:data][:allNeeds].last[:zipCode]).to_not eq("12345")
        expect(needs[:data][:allNeeds].last[:supportersNeeded]).to_not eq(1)
        expect(needs[:data][:allNeeds].last[:status]).to_not eq("active")
      end

    end

    describe 'upcomingActiveNeeds' do
      it 'can return all fields for needs whose end date has not yet passed' do
        need_1 = Need.create(title: "a need", description: "a test to see if we can test", point_of_contact: "test1@gmail.com", start_time: "2021-11-24 12:00", end_time: "2021-11-24 14:00", zip_code: "12345", supporters_needed: 12, status: "active")
        need_2 = Need.create(title: "need 2", description: "the second test", point_of_contact: "test2@gmail.com", start_time: "2021-08-24 12:00", end_time: "2021-08-24 19:00", zip_code: "12345", supporters_needed: 4, status: "active")
        need_3 = Need.create(title: "need 3", description: "the third test", point_of_contact: "test3@gmail.com", start_time: "2021-08-24 12:00", end_time: "2021-09-24 12:00", zip_code: "12345", supporters_needed: 1, status: "active")

        cat_1 = Category.create!(tag: "Food")
        cat_2 = Category.create!(tag: "Manual Labor")
        cat_3 = Category.create!(tag: "Cleanup")

        NeedCategory.create!(need_id: need_1.id, category_id: cat_1.id)
        NeedCategory.create!(need_id: need_1.id, category_id: cat_2.id)
        NeedCategory.create!(need_id: need_2.id, category_id: cat_2.id)
        NeedCategory.create!(need_id: need_3.id, category_id: cat_3.id)

        query = <<~GQL
                { upcomingActiveNeeds
                  {
                    title
                    description
                    pointOfContact
                    startTime
                    endTime
                    zipCode
                    supportersNeeded
                    status
                    categories {
                      id
                      tag
                    }
                  }
                }
                GQL

        post '/graphql', params: {query: query}

        needs = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")

        expect(needs[:data][:upcomingActiveNeeds]).to be_a(Array)
        expect(needs[:data][:upcomingActiveNeeds].count).to eq(2)

        expect(needs[:data][:upcomingActiveNeeds].first[:title]).to eq("a need")
        expect(needs[:data][:upcomingActiveNeeds].first[:description]).to eq("a test to see if we can test")
        expect(needs[:data][:upcomingActiveNeeds].first[:pointOfContact]).to eq("test1@gmail.com")
        expect(needs[:data][:upcomingActiveNeeds].first[:startTime]).to eq("2021-11-24 12:00")
        expect(needs[:data][:upcomingActiveNeeds].first[:endTime]).to eq("2021-11-24 14:00")
        expect(needs[:data][:upcomingActiveNeeds].first[:zipCode]).to eq("12345")
        expect(needs[:data][:upcomingActiveNeeds].first[:supportersNeeded]).to eq(12)
        expect(needs[:data][:upcomingActiveNeeds].first[:status]).to eq("active")
        expect(needs[:data][:upcomingActiveNeeds].first[:categories].first[:tag]).to eq(cat_1.tag)
        expect(needs[:data][:upcomingActiveNeeds].first[:categories].last[:tag]).to eq(cat_2.tag)

        expect(needs[:data][:upcomingActiveNeeds].last[:title]).to eq("need 3")
        expect(needs[:data][:upcomingActiveNeeds].last[:description]).to eq("the third test")
        expect(needs[:data][:upcomingActiveNeeds].last[:pointOfContact]).to eq("test3@gmail.com")
        expect(needs[:data][:upcomingActiveNeeds].last[:startTime]).to eq("2021-08-24 12:00")
        expect(needs[:data][:upcomingActiveNeeds].last[:endTime]).to eq("2021-09-24 12:00")
        expect(needs[:data][:upcomingActiveNeeds].last[:zipCode]).to eq("12345")
        expect(needs[:data][:upcomingActiveNeeds].last[:supportersNeeded]).to eq(1)
        expect(needs[:data][:upcomingActiveNeeds].last[:status]).to eq("active")
        expect(needs[:data][:upcomingActiveNeeds].last[:categories].first[:tag]).to eq(cat_3.tag)
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

        cat_1 = Category.create!(tag: "Food")
        cat_2 = Category.create!(tag: "Manual Labor")
        cat_3 = Category.create!(tag: "Cleanup")

        NeedCategory.create!(need_id: need_1.id, category_id: cat_1.id)
        NeedCategory.create!(need_id: need_1.id, category_id: cat_2.id)
        NeedCategory.create!(need_id: need_2.id, category_id: cat_2.id)
        NeedCategory.create!(need_id: need_3.id, category_id: cat_3.id)

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
                      categories {
                        id
                        tag
                      }
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
        expect(needs[:data][:need][:categories].length).to eq(2)
        expect(needs[:data][:need][:categories].first[:tag]).to eq(cat_1.tag)
        expect(needs[:data][:need][:categories].last[:tag]).to eq(cat_2.tag)
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
