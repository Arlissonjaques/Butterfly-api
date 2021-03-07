require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:color) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should belong_to(:category) }
  end
end
