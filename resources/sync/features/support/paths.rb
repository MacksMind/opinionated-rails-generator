module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      root_path
    
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    when /my password reset page/i
      account_password_reset_path(@user.perishable_token)
    when /my edit password reset page/i
      edit_account_password_reset_path(@user.perishable_token)
    when /an invalid edit password reset page/i
      edit_account_password_reset_path("blah")
    when /my account confirmation page/i
      edit_account_confirmation_path(@user.perishable_token)
    when /an invalid account confirmation page/i
      edit_account_confirmation_path("blah")
    else
      page_matches = /the (.*) page/.match(page_name)

      if (page_matches && path = page_matches[1].parameterize(sep='_').concat("_path").to_sym) && ActionController::Base.helpers.respond_to?(path)
        send(path)
      else
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
