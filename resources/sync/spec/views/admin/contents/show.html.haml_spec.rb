require 'spec_helper'

describe "admin/contents/show.html.erb" do
  before(:each) do
    @content = assign(:content, stub_model(Content,
      :name => "Name",
      :slug => "name",
      :title => "Title",
      :html => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Name/)
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
  end
end
