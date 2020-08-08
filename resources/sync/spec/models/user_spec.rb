# frozen_string_literal: true

require 'rails_helper'

describe User do
  it 'creates a new instance given valid attributes' do
    user = FactoryBot.build(:user)
    user.save!
  end

  it 'cancels account' do
    user = FactoryBot.create(:user)
    user.cancel
    expect(user.active).to be(false)
  end

  it 'sets country code and read name' do
    user = FactoryBot.create(:user)
    expect(user.country_code).to eq 'US'
    expect(user.country.name).to eq 'UNITED STATES'
    user.update!(state_id: nil, country_code: 'ZA')
    expect(user.country_code).to eq 'ZA'
    expect(user.country.name).to eq 'SOUTH AFRICA'
  end

  it 'sets state code and read name' do
    user = FactoryBot.create(:user)
    user.update!(state_code: 'CA')
    expect(user.state_code).to eq 'CA'
    expect(user.state.name).to eq 'California'
  end

  it 'allows missing country and state' do
    expect { FactoryBot.create(:user, country_code: nil, state_code: nil) }.not_to raise_error
  end

  it 'allows country without state' do
    expect { FactoryBot.create(:user, country_code: 'ZA') }.not_to raise_error
  end

  it 'allows country with state' do
    expect { FactoryBot.create(:user, country_code: 'US', state_code: 'IN') }.not_to raise_error
  end

  it 'denys stateless country with state' do
    expect { FactoryBot.create(:user, country_code: 'ZA', state_code: 'IN') }
      .to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'denys stateful country with missing state' do
    expect { FactoryBot.create(:user, country_code: 'US', state_code: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'denys stateful country with wrong state' do
    expect { FactoryBot.create(:user, country_code: 'CA', state_code: 'IN') }
      .to raise_error(ActiveRecord::RecordInvalid)
  end
end
