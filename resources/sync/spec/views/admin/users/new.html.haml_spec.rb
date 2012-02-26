require 'spec_helper'

describe "/admin/users/new" do
  include Admin::UsersHelper

  before(:each) do
    assign(:user, stub_model(User,
      :email => "value for email",
      :name => "value for name"
    ).as_new_record{|u| u.stub(:roles => []) })
  end

  it "renders new user form" do
    render

    rendered.should have_selector("form", :action => admin_users_path, :method => "post") do |form|
      form.should have_selector("input#user_email", :name => "user[email]")
      form.should have_selector("input#user_first_name", :name => "user[first_name]")
      form.should have_selector("input#user_last_name", :name => "user[last_name]")
    end
  end
end
