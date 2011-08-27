require 'spec_helper'

describe "Contents" do
  before(:each) do
    user = Factory(:admin_user)
    post user_session_path, :user => { :email => user.email, :password => user.password }
  end

  describe "GET /admin/contents" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get admin_contents_path
      response.status.should be(200)
    end
  end
end
