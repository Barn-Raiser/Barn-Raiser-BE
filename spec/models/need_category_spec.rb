require 'rails_helper'

RSpec.describe NeedCategory, type: :model do

  describe 'relationships' do
    it { should belong_to(:category) }
    it { should belong_to(:need) }
  end



  describe 'methods' do
    it 'upcoming_active' do
      need_1 = Need.create(title: "need 1", description: "a test to see if we can test", point_of_contact: "test1@gmail.com", start_time: "2021-11-24 12:00", end_time: "2021-11-24 14:00", zip_code: "12345", supporters_needed: 12, status: "active")
      need_2 = Need.create(title: "need 2", description: "the second test", point_of_contact: "test2@gmail.com", start_time: "2021-08-24 12:00", end_time: "2021-08-24 19:00", zip_code: "12345", supporters_needed: 4, status: "active")
      need_3 = Need.create(title: "need 3", description: "the third test", point_of_contact: "test3@gmail.com", start_time: "2021-08-24 12:00", end_time: "2021-09-24 12:00", zip_code: "12345", supporters_needed: 1, status: "active")

      cat_1 = Category.create!(tag: "Food")
      cat_2 = Category.create!(tag: "Manual Labor")
      cat_3 = Category.create!(tag: "Cleanup")

      NeedCategory.create!(need_id: need_1.id, category_id: cat_1.id)
      NeedCategory.create!(need_id: need_1.id, category_id: cat_2.id)
      NeedCategory.create!(need_id: need_2.id, category_id: cat_2.id)
      NeedCategory.create!(need_id: need_3.id, category_id: cat_3.id)

      allow(Time).to receive(:now) do
        DateTime.new(2021,9,5,12)
      end

      test = Need.upcoming_active

      expect(test.length).to eq(2)
      expect(test.first.title).to eq('need 1')
      expect(test[1].title).to_not eq('need 2')
      expect(test.last.title).to eq('need 3')
    end

    it 'all_active' do
      need_1 = Need.create(title: "need 1", description: "a test to see if we can test", point_of_contact: "test1@gmail.com", start_time: "2021-11-24 12:00", end_time: "2021-11-24 14:00", zip_code: "12345", supporters_needed: 12, status: "active")
      need_2 = Need.create(title: "need 2", description: "the second test", point_of_contact: "test2@gmail.com", start_time: "2021-08-24 12:00", end_time: "2021-08-24 19:00", zip_code: "12345", supporters_needed: 4, status: "rejected")
      need_3 = Need.create(title: "need 3", description: "the third test", point_of_contact: "test3@gmail.com", start_time: "2021-08-24 12:00", end_time: "2021-09-24 12:00", zip_code: "12345", supporters_needed: 1, status: "active")

      cat_1 = Category.create!(tag: "Food")
      cat_2 = Category.create!(tag: "Manual Labor")
      cat_3 = Category.create!(tag: "Cleanup")

      NeedCategory.create!(need_id: need_1.id, category_id: cat_1.id)
      NeedCategory.create!(need_id: need_1.id, category_id: cat_2.id)
      NeedCategory.create!(need_id: need_2.id, category_id: cat_2.id)
      NeedCategory.create!(need_id: need_3.id, category_id: cat_3.id)

      allow(Time).to receive(:now) do
        DateTime.new(2021,9,5,12)
      end

      test = Need.all_active


      # un-coment out below feields once we make it possible for something to not be active. 
      # expect(test.length).to eq(2)
      expect(test.first.title).to eq('need 1')
      # expect(test[1].title).to_not eq('need 2')
      expect(test.last.title).to eq('need 3')
    end
  end

end
