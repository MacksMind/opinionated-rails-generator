require 'spec_helper'

describe "Users" do
  before(:each) do
    @user = FactoryGirl.create(:user, :password => "testing")
    ActionMailer::Base.deliveries = []
  end

  describe "when signed in" do
    before(:each) do
      signin_user @user
    end

    it "can update email and password" do
      visit edit_user_registration_path
      fill_in "Email", :with => "alicia@example.com"
      fill_in "user_password", :with => "soooper"
      fill_in "Password confirmation", :with => "soooper"
      fill_in "Current password", :with => "testing"
      click_button "Update"
      current_path.should == contents_path(:action => 'home')
      page.should have_content "You updated your account successfully."
      page.should have_content "alicia@example.com"
      @user.reload.valid_password?("soooper").should be_true
    end

    it "can update, :with =>out current password" do
      visit edit_user_registration_path
      fill_in "Email", :with => "alicia@example.com"
      fill_in "user_password", :with => "soooper"
      fill_in "Password confirmation", :with => "soooper"
      click_button "Update"
      page.should have_content "Current password can't be blank"
      find_field("user[email]").value.should == "alicia@example.com"
      @user.reload.valid_password?("testing").should be_true
    end

    it "can't set password to blank" do
      visit edit_user_registration_path
      fill_in "user_password", :with => ""
      fill_in "Password confirmation", :with => ""
      fill_in "Current password", :with => "testing"
      click_button "Update"
      current_path.should == contents_path(:action => 'home')
      page.should have_content "You updated your account successfully."
      @user.reload.valid_password?("testing").should be_true
    end

    it "can sign out" do
      click_link "Sign out"
      current_path.should == root_path
      page.should have_content "Signed out successfully."
    end

    it "can cancel account" do
      visit edit_user_registration_path
      click_link "Cancel my account"
      current_path.should == root_path
      page.should have_content "Bye! Your account was successfully cancelled. We hope to see you again soon."
    end

    it "can't visit signup page" do
      visit new_user_registration_path
      current_path.should == contents_path(:action => 'home')
    end
  end

  describe "when not signed in" do
    it "can register" do
      visit new_user_registration_path
      fill_in "Email", :with => "jq@example.com"
      fill_in "First name", :with => "John"
      fill_in "Last name", :with => "Smith"
      select "(GMT-05:00) Eastern Time (US & Canada)", :from => "Time zone"
      fill_in "user_password", :with => "humpty dumpty"
      fill_in "Password confirmation", :with => "humpty dumpty"
      fill_in "Phone number", :with => "BR549"
      fill_in "Company name", :with => "State Lunatic Hospital"
      fill_in "Address line 1", :with => "Kirkbride Building"
      fill_in "Address line 2", :with => "450 Maple St"
      fill_in "City", :with => "Danvers"
      select "Massachusetts", :from => "State/Province"
      fill_in "Postal code", :with => "01923"
      select "UNITED STATES", :from => "Country"
      click_button "Sign up"
      current_path.should == contents_path(:action => 'home')
      page.should have_content "Welcome! You have signed up successfully."
    end

    it "can't register with missing information" do
      visit new_user_registration_path
      fill_in "user_password", :with => "humpty dumpty"
      click_button "Sign up"
      current_path.should == user_registration_path
      page.should have_content("errors prohibited")
    end

    it "can't see protected pages" do
      visit edit_user_registration_path
      current_path.should == new_user_session_path
      page.should have_content "You need to sign in or sign up before continuing."
    end

    it "can't signin with invalid info" do
      visit new_user_session_path
      fill_in "Email", :with => @user.email
      fill_in "Password", :with => "qwpefoij"
      click_button "Sign in"
      current_path.should == new_user_session_path
      page.should have_content "Invalid email or password"

      visit new_user_session_path
      fill_in "Email", :with => "wefoijwoeij"
      fill_in "Password", :with => @user.password
      click_button "Sign in"
      current_path.should == new_user_session_path
      page.should have_content "Invalid email or password"
    end

    it "signs in from signin page" do
      visit new_user_session_path
      fill_in "Email", :with => @user.email
      fill_in "Password", :with => @user.password
      click_button "Sign in"
      current_path.should == contents_path(:action => 'home')
    end

    it "sends a forgot password email" do
      visit new_user_session_path
      click_link "Forgot your password?"
      fill_in "Email", :with => @user.email
      click_button "Send me reset password instructions"
      current_path.should == new_user_session_path
      page.should have_content "You will receive an email with instructions about how to reset your password in a few minutes."
      ActionMailer::Base.deliveries.last.to.should include(@user.email)

      #follow email line
      visit edit_user_password_path(:reset_password_token   => @user.reload.reset_password_token)
      fill_in "New password", :with => ""
      fill_in "Confirm new password", :with => ""
      click_button "Change my password"
      page.should have_content "Password can't be blank"

      visit edit_user_password_path(:reset_password_token   => @user.reload.reset_password_token)
      fill_in "New password", :with => "funkynew"
      fill_in "Confirm new password", :with => "funkynew"
      click_button "Change my password"
      @user.reload.valid_password?("funkynew").should be_true
    end

    it "doesn't send a forgot password email" do
      visit new_user_session_path
      click_link "Forgot your password?"
      fill_in "Email", :with => "weofij"
      click_button "Send me reset password instructions"
      current_path.should == user_password_path
      page.should have_content "Email not found"
      ActionMailer::Base.deliveries.should be_empty
    end
  end
end
