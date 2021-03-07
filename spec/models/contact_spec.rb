require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
    it { should validate_presence_of(:message) }
  end

  describe 'associations' do
    it { should belong_to(:product) }
  end
end
