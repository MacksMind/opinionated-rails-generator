Before do
  Content.find_by_name('Home') || Factory(:content, :name => 'Home')
end
