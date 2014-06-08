require 'rails_helper'

describe User do
  it "should create a new instance given valid attributes" do
    user = FactoryGirl.build(:user)
    user.save!
  end

  it "should cancel account" do
    user = FactoryGirl.create(:user)
    user.cancel
    expect(user.active).to be(false)
  end

  it "should set country code and read name" do
    user = FactoryGirl.create(:user)
    expect(user.country_code).to eq "US"
    expect(user.country.name).to eq "UNITED STATES"
    user.update_attributes(country_code: "ZA")
    expect(user.country_code).to eq "ZA"
    expect(user.country.name).to eq "SOUTH AFRICA"
  end

  it "should set state code and read name" do
    user = FactoryGirl.create(:user)
    user.update_attributes(state_code: "CA")
    expect(user.state_code).to eq "CA"
    expect(user.state.name).to eq "California"
  end
end
