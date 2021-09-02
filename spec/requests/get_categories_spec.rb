require 'rails_helper'

RSpec.describe 'get info on need', type: :request do
  describe 'find list of needs' do
    describe 'allNeeds' do
      it 'can return all information' do
        category_1 = Category.create( tag: "moveing")
        category_2 = Category.create(tag: "food preporation")
        category_3 = Category.create(tag: "orginizing events")

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
        expect(needs[:data][:allCategories].first[:tag]).to eq("moveing")

        expect(needs[:data][:allCategories].last).to have_key(:tag)
        expect(needs[:data][:allCategories].last[:tag]).to eq("orginizing events")
      end


    end
  end



end
