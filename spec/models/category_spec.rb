require 'rails_helper'

RSpec.describe Category, type: :model do

  describe 'relationships' do
    it {should have_many(:need).through(:need_category)}
  end

  describe 'validations' do
    it {should validate_presence_of(:tag)}
  end

end
