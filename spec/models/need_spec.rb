require 'rails_helper'

RSpec.describe Need, type: :model do

  describe 'relationships' do
    it {should have_many(:need_category)}
    it {should have_many(:category).through(:need_category)}
  end

  describe 'validations' do
    it {should validate_presence_of(:point_of_contact)}
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:start_time)}
    it {should validate_presence_of(:end_time)}
    it {should validate_presence_of(:zip_code)}
    it {should validate_presence_of(:supporters_needed)}
    it {should validate_presence_of(:status)}
  end
end
