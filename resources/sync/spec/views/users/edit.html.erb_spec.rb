require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/edit.html.erb" do
  include UsersHelper

  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :new_record? => false,
      :email => "value for email",
      :name => "value for name",
      :roles => []
    )
  end

  it "renders the edit user form" do
    render

    response.should have_tag("form[action=#{user_path(@user)}][method=post]") do
      with_tag('input#user_email[name=?]', "user[email]")
      with_tag('input#user_name[name=?]', "user[name]")
    end
  end
end
