require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/show.html.erb" do
  include UsersHelper
  before(:each) do
    assign(:user, stub_model(User,
      :email => "value for email",
      :name => "value for name"
    ){|u| u.stub(:roles => []) })
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain(/value\ for\ email/)
    rendered.should contain(/value\ for\ name/)
  end
end
