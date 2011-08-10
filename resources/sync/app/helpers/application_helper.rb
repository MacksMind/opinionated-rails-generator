module ApplicationHelper
  def menu_link(name, options = {}, html_options = {})
    link_to_unless_current(name, options, html_options) do
      raw "<span>#{name}</span>"
    end
  end
end
