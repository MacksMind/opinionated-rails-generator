require 'spec_helper'

describe "accounts/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      company_name: "MyString"
    ))
  end

  it "renders the edit account form" do
    render

    assert_select "form", action: account_path, method: "post" do
      assert_select "input#user_company_name", name: "user[company_name]"
    end
  end
end
