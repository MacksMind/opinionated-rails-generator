require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/index.html.erb" do
  include UsersHelper

  before(:each) do
    assigns[:users] = [
      stub_model(User,
        :email => "value for email",
        :name => "value for name",
        :roles => []
      ),
      stub_model(User,
        :email => "value for email",
        :name => "value for name",
        :roles => []
      )
    ]
  end

  it "renders a list of users" do
    render
    response.should have_tag("tr>td", "value for email".to_s, 2)
    response.should have_tag("tr>td", "value for email".to_s, 2)
  end
end
