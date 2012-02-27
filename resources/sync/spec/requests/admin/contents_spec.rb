require 'spec_helper'

describe "Contents" do
  before(:each) do
    Content.find_by_name('Home') || Factory(:content, :name => 'Home')
    @user = Factory(:admin_user)
    signin_user @user
  end

  it "creates new content" do
    visit new_admin_content_path
    fill_in "Name", :with => "name 1"
    fill_in "Title", :with => "title 1"
    fill_in "Html", :with => "html 1"
    click_button "Create"
    page.should have_content "name 1"
    page.should have_content "title 1"
    page.should have_content "html 1"
  end
end
