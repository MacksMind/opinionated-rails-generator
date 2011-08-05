require 'spec_helper'

describe "contents/show.html.erb" do
  before(:each) do
    @content = assign(:content, stub_model(Content,
      :name => "Name",
      :title => "Title",
      :html => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
