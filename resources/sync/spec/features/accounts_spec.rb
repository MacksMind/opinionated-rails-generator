require 'rails_helper'

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
      expect(current_path).to eq(dashboard_home_path)
      expect(page).to have_content "You updated your account successfully."
      visit edit_account_path
      expect(find_field("Company").value).to eq("Central Supply")
    end
  end
end
