# frozen_string_literal: true

require "rails_helper"

describe "/shared/user" do
  before(:each) do
    assign(:user, stub_model(User,
      id: SecureRandom.uuid,
      email: "value for email",
      full_name: "value for name",
      country: stub_model(Country, name: "state of mind")
    ) { |u| u.roles = [] })
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to have_content("value for email")
    expect(rendered).to have_content("value for name")
  end
end
