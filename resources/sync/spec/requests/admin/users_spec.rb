require 'spec_helper'

describe "Admin/Users" do
  before(:each) do
    Content.find_by_name('Home') || Factory(:content, :name => 'Home')
    @user = Factory(:admin_user, :password => "testing")
    signin_user @user
  end

  it "creates a new user" do
    visit new_admin_user_path
    fill_in "Email", :with => "new_user@example.com"
    fill_in "First name", :with => "Joe"
    fill_in "Last name", :with => "Blow"
    fill_in "Password", :with => "asecret"
    fill_in "Password confirmation", :with => "asecret"
    fill_in "Phone number", :with => "BR549"
    fill_in "Company name", :with => "State Lunatic Hospital"
    fill_in "Title", :with => "Inmate"
    fill_in "Address line 1", :with => "Kirkbride Building"
    fill_in "Address line 2", :with => "450 Maple St"
    fill_in "City", :with => "Danvers"
    select "Massachusetts", :from => "State/Province"
    fill_in "Postal code", :with => "01923"
    select "UNITED STATES", :from => "Country"
    check "Admin"
    click_button "Create"
    page.should have_content "new_user@example.com"
    page.should have_content "Joe Blow"
    page.should have_content "BR549"
    page.should have_content "State Lunatic Hospital"
    page.should have_content "Inmate"
    page.should have_content "Kirkbride Building"
    page.should have_content "450 Maple St"
    page.should have_content "Danvers MA 01923"
    page.should have_content "UNITED STATES"
    page.should have_content "admin"
    click_link "Edit"
    fill_in "First name", :with => "Jane"
    fill_in "Last name", :with => "Doe"
    fill_in "Password", :with => "new secret"
    fill_in "Password confirmation", :with => "new secret"
    click_button "Update"
    page.should have_content "Jane Doe"
    click_link "Edit"
    fill_in "First name", :with => "Jane"
    fill_in "Last name", :with => "Doe"
    click_button "Update"
    page.should have_content "Jane Doe"
  end

  it "allows masquerade" do
    user = Factory(:user)
    visit admin_users_path
    click_link "Masq"
    current_path.should == root_path
    page.should have_content user.email
  end

end
