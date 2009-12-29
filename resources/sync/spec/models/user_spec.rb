require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it "should create a new instance given valid attributes" do
    user = Factory.build(:user)
    user.save!
  end
end
