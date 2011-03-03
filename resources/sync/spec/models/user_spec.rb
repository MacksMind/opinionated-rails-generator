require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it "should create a new instance given valid attributes" do
    user = Factory.build(:user)
    user.save!
  end

  it "should cancel account" do
    user = Factory(:user)
    user.cancel
    user.active.should be(false)
  end
end
