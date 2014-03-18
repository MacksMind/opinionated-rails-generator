require 'spec_helper'

describe "/admin/users/edit" do
  include Admin::UsersHelper

  before(:each) do
    @user = assign(:user, stub_model(User,
      new_record?: false,
      email: "value for email",
      name: "value for name"
    ){|u| u.stub(roles: []) })
  end

  it "renders the edit user form" do
    render

    assert_select "form", action: admin_user_path(@user), method: "post" do
      assert_select "input#user_first_name", name: "user[first_name]"
      assert_select "input#user_last_name", name: "user[last_name]"
    end
  end
end
