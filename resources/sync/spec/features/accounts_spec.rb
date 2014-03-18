require 'spec_helper'

describe "Accounts" do
  describe "when signed in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      signin_user @user
    end

    it "can update miscellaneous info" do
      visit edit_account_path
      fill_in "Company", with: "Central Supply"
      click_button "Update"
      current_path.should == contents_path(action: 'home')
      page.should have_content "You updated your account successfully."
      visit edit_account_path
      find_field("Company").value.should == "Central Supply"
    end
  end
end
