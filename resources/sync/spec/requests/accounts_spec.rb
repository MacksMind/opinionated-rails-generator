require 'spec_helper'

describe "Accounts" do
  before(:each) do
    user = Factory(:user)
    post user_session_path, :user => { :email => user.email, :password => user.password }
  end

  describe "GET /account/edit" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get edit_account_path
      response.status.should be(200)
    end
  end
end
