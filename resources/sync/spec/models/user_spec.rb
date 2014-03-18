require 'spec_helper'

describe User do
  it "should create a new instance given valid attributes" do
    user = FactoryGirl.build(:user)
    user.save!
  end

  it "should cancel account" do
    user = FactoryGirl.create(:user)
    user.cancel
    user.active.should be(false)
  end

  it "should set country code and read name" do
    user = FactoryGirl.create(:user)
    user.country_code.should eq "US"
    user.country.name.should eq "UNITED STATES"
    user.update_attributes(country_code: "ZA")
    user.country_code.should eq "ZA"
    user.country.name.should eq "SOUTH AFRICA"
  end

  it "should set state code and read name" do
    user = FactoryGirl.create(:user)
    user.update_attributes(state_code: "CA")
    user.state_code.should eq "CA"
    user.state.name.should eq "California"
  end
end
