require 'spec_helper'

describe Merchant do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email_address) }
  it { should validate_presence_of(:hashed_screen_name) }

  describe 'email address' do
    it { should allow_value("test@test2.com").for(:email_address) }
    it { should_not allow_value("%test@test2.com").for(:email_address) }

    it 'validates uniqueness' do
      m = FactoryGirl.create(:merchant)
      expect{ FactoryGirl.create(:merchant, email_address: m.email_address.capitalize) }.to raise_error ActiveRecord::RecordInvalid
    end
  end

end
