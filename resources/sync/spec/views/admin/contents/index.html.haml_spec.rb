require 'spec_helper'

describe "admin/contents/index" do
  before(:each) do
    assign(:contents, [
      stub_model(Content,
        :name => "Name",
        :slug => "name",
        :title => "Title",
        :html => "MyText"
      ),
      stub_model(Content,
        :name => "Name",
        :slug => "name",
        :title => "Title",
        :html => "MyText"
      )
    ])
  end

  it "renders a list of contents" do
    render
    assert_select "div.span-3", :text => "Name".to_s, :count => 2
    assert_select "div.span-3", :text => "Title".to_s, :count => 2
    assert_select "div.span-14", :text => "MyText".to_s, :count => 2
  end
end
