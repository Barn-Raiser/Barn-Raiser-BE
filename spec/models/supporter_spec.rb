require 'rails_helper'

RSpec.describe Supporter, type: :model do
  describe 'relationships' do
    it {should belong_to(:need)}
    it {should have_many(:categories).through(:need)}

  end
end
