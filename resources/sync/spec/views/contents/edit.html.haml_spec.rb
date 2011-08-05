require 'spec_helper'

describe "contents/edit.html.erb" do
  before(:each) do
    @content = assign(:content, stub_model(Content,
      :name => "MyString",
      :title => "MyString",
      :html => "MyText"
    ))
  end

  it "renders the edit content form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contents_path(@content), :method => "post" do
      assert_select "input#content_name", :name => "content[name]"
      assert_select "input#content_title", :name => "content[title]"
      assert_select "textarea#content_html", :name => "content[html]"
    end
  end
end
