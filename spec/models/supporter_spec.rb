require 'rails_helper'

RSpec.describe Supporter, type: :model do
  describe 'relationships' do
    it {should belong_to(:need)}
  end
end
