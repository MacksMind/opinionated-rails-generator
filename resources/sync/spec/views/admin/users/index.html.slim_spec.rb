require 'rails_helper'

describe "/admin/users/index" do
  include Admin::UsersHelper

  before(:each) do
    assign(:users, [
      stub_model(User,
        email: "value for email",
        name: "value for name"
      ) { |u| u.roles = [] },
      stub_model(User,
        email: "value for email",
        name: "value for name"
      ) { |u| u.roles = [] }
    ])
  end

  it "renders a list of users" do
    render
    expect(rendered).to have_selector "tr>td", text: "value for name", count: 2
    expect(rendered).to have_selector "tr>td", text: "value for email", count: 2
  end
end
