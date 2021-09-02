require 'rails_helper'

RSpec.describe NeedCategory, type: :model do

  describe 'relationships' do
    it { should belong_to(:category) }
    it { should belong_to(:need) }
  end

end
