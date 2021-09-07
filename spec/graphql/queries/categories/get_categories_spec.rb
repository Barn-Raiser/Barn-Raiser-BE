require 'rails_helper'

RSpec.describe 'get all categories', type: :request do
  describe 'find list of categories' do
    describe 'allCategories' do
      it 'can return all information' do
        category_1 = Category.create( tag: "moving")
        category_2 = Category.create(tag: "food preparation")
        category_3 = Category.create(tag: "organizing events")

        query = <<~GQL
                { allCategories
                  {
                    tag
                  }
                }
                GQL

        post '/graphql', params: {query: query}

        needs = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")

        expect(needs[:data][:allCategories]).to be_a(Array)
        expect(needs[:data][:allCategories].count).to eq(3)

        expect(needs[:data][:allCategories].first).to have_key(:tag)
        expect(needs[:data][:allCategories].first[:tag]).to eq("moving")

        expect(needs[:data][:allCategories].last).to have_key(:tag)
        expect(needs[:data][:allCategories].last[:tag]).to eq("organizing events")
      end
    end

    describe 'suportersByCategory' do
      it 'can return all information' do
        need_1 = Need.create(title: "need 1", description: "a test to see if we can test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 12, status: "active")
        need_2 = Need.create(title: "need 2", description: "the second test", point_of_contact: "email@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 4, status: "active")
        need_3 = Need.create(title: "need 3", description: "the theird test", point_of_contact: "test@gmail.com", start_time: "string value", end_time: "string value", zip_code: "12345", supporters_needed: 1, status: "active")

        cat_1 = Category.create!(tag: "Food")
        cat_2 = Category.create!(tag: "Manual Labor")
        cat_3 = Category.create!(tag: "Cleanup")

        NeedCategory.create!(need_id: need_1.id, category_id: cat_1.id)
        NeedCategory.create!(need_id: need_1.id, category_id: cat_2.id)
        NeedCategory.create!(need_id: need_2.id, category_id: cat_2.id)
        NeedCategory.create!(need_id: need_3.id, category_id: cat_3.id)

        supporter_1 = Supporter.create(need_id: need_1.id, name: 'albert', email: "testing@test.com")
        supporter_2 = Supporter.create(need_id: need_1.id, name: 'bob', email: "rando@test.com")
        supporter_3 = Supporter.create(need_id: need_2.id, name: 'albert', email: "rando@test.com")
        supporter_4 = Supporter.create(need_id: need_3.id, name: 'bob', email: "rando@test.com")
        supporter_5 = Supporter.create(need_id: need_3.id, name: 'cat', email: "kitty@test.com")




        query = <<~GQL
                { allCategories
                  {
                    tag
                    supporters {
                      name
                      email
                    }
                  }
                }
                GQL

        post '/graphql', params: {query: query}

        suporters = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")

        # expect(suporters).to eq(nil)
        expect(suporters[:data][:allCategories]).to be_a(Array)
        expect(suporters[:data][:allCategories].count).to eq(3)

        expect(suporters[:data][:allCategories][0]).to have_key(:tag)
        expect(suporters[:data][:allCategories][0][:tag]).to eq("Food")
        expect(suporters[:data][:allCategories][0]).to have_key(:supporters)
        expect(suporters[:data][:allCategories][0][:supporters].class).to eq(Array)
        expect(suporters[:data][:allCategories][0][:supporters][0][:email]).to eq("testing@test.com")
        expect(suporters[:data][:allCategories][0][:supporters][0][:name]).to eq("albert")
        expect(suporters[:data][:allCategories][0][:supporters][1][:email]).to eq("rando@test.com")
        expect(suporters[:data][:allCategories][0][:supporters][1][:name]).to eq("bob")

        expect(suporters[:data][:allCategories][1]).to have_key(:tag)
        expect(suporters[:data][:allCategories][1][:tag]).to eq("Manual Labor")
        expect(suporters[:data][:allCategories][1]).to have_key(:supporters)
        expect(suporters[:data][:allCategories][1][:supporters].class).to eq(Array)
        expect(suporters[:data][:allCategories][1][:supporters][0][:email]).to eq("testing@test.com")
        expect(suporters[:data][:allCategories][1][:supporters][0][:name]).to eq("albert")
        expect(suporters[:data][:allCategories][1][:supporters][1][:email]).to eq("rando@test.com")
        expect(suporters[:data][:allCategories][1][:supporters][1][:name]).to eq("bob")

        expect(suporters[:data][:allCategories][2]).to have_key(:tag)
        expect(suporters[:data][:allCategories][2][:tag]).to eq("Cleanup")
        expect(suporters[:data][:allCategories][2]).to have_key(:supporters)
        expect(suporters[:data][:allCategories][2][:supporters].class).to eq(Array)
        expect(suporters[:data][:allCategories][2][:supporters][1][:email]).to eq("kitty@test.com")
        expect(suporters[:data][:allCategories][2][:supporters][1][:name]).to eq("cat")
        expect(suporters[:data][:allCategories][2][:supporters][0][:email]).to eq("rando@test.com")
        expect(suporters[:data][:allCategories][2][:supporters][0][:name]).to eq("bob")

      end
    end
  end
end
