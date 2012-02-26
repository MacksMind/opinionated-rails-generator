require 'spec_helper'

describe "/admin/users/edit" do
  include Admin::UsersHelper

  before(:each) do
    @user = assign(:user, stub_model(User,
      :new_record? => false,
      :email => "value for email",
      :name => "value for name"
    ){|u| u.stub(:roles => []) })
  end

  it "renders the edit user form" do
    render

    rendered.should have_selector("form", :action => admin_user_path(@user), :method => "post") do |form|
      form.should have_selector("input#user_first_name", :name => "user[first_name]")
      form.should have_selector("input#user_last_name", :name => "user[last_name]")
    end
  end
end
