# frozen_string_literal: true

require('rails_helper')

describe 'Users' do
  let(:user) { FactoryBot.create(:user, password: 'testing1') }

  before do
    ActionMailer::Base.deliveries = []
  end

  describe 'when signed in' do
    before do
      sign_in(user)
    end

    it 'can update email and password' do
      visit edit_user_registration_path
      fill_in 'Email', with: 'alicia@example.com'
      fill_in 'user_password', with: 'sooooper'
      fill_in 'Password confirmation', with: 'sooooper'
      fill_in 'Current password', with: 'testing1'
      click_button 'Update'
      expect(page).to(have_current_path(dashboard_index_path, ignore_query: true))
      expect(page)
        .to(have_content('You updated your account successfully, but we need to verify your new email address.'))
      expect(user.reload.valid_password?('sooooper')).to(be(true))
    end

    it 'can update, with:out current password' do
      visit edit_user_registration_path
      fill_in 'Email', with: 'alicia@example.com'
      fill_in 'user_password', with: 'sooooper'
      fill_in 'Password confirmation', with: 'sooooper'
      click_button 'Update'
      expect(page).to(have_content("Current password can't be blank"))
      expect(find_field('user[email]').value).to(eq('alicia@example.com'))
      expect(user.reload.valid_password?('testing1')).to(be(true))
    end

    it "can't set password to blank" do
      visit edit_user_registration_path
      fill_in 'user_password', with: ''
      fill_in 'Password confirmation', with: ''
      fill_in 'Current password', with: 'testing1'
      click_button 'Update'
      expect(page).to(have_current_path(dashboard_index_path, ignore_query: true))
      expect(page).to(have_content('Your account has been updated successfully.'))
      expect(user.reload.valid_password?('testing1')).to(be(true))
    end

    it 'can sign out' do
      click_link 'Sign out'
      expect(page).to(have_current_path(root_path, ignore_query: true))
      expect(page).to(have_content('Signed out successfully.'))
    end

    it 'can cancel account' do
      visit edit_user_registration_path
      click_link 'Cancel my account'
      expect(page).to(have_current_path(root_path, ignore_query: true))
      expect(page).to(have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.'))
    end

    it "can't visit signup page" do
      visit new_user_registration_path
      expect(page).to(have_current_path(dashboard_index_path, ignore_query: true))
    end
  end

  describe 'when not signed in' do
    it 'can register' do
      visit new_user_registration_path
      fill_in 'Email', with: 'jq@example.com'
      fill_in 'First name', with: 'John'
      fill_in 'Last name', with: 'Smith'
      fill_in 'user_password', with: 'humpty dumpty'
      fill_in 'Password confirmation', with: 'humpty dumpty'
      click_button 'Sign up'
      expect(page).to(have_current_path(dashboard_index_path, ignore_query: true))
      expect(page).to(have_content('Welcome! You have signed up successfully.'))
    end

    it "can't register with missing information" do
      visit new_user_registration_path
      fill_in 'user_password', with: 'humpty dumpty'
      click_button 'Sign up'
      expect(page).to(have_current_path(user_registration_path, ignore_query: true))
      expect(page).to(have_content('errors prohibited'))
    end

    it "can't see protected pages" do
      visit edit_user_registration_path
      expect(page).to(have_current_path(new_user_session_path, ignore_query: true))
      expect(page).to(have_content('You need to sign in or sign up before continuing.'))
    end

    it "can't signin with invalid info" do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'qwpefoij'
      click_button 'Sign in'
      expect(page).to(have_current_path(new_user_session_path, ignore_query: true))
      expect(page).to(have_content('Invalid Email or password'))

      visit new_user_session_path
      fill_in 'Email', with: 'wefoijwoeij'
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      expect(page).to(have_current_path(new_user_session_path, ignore_query: true))
      expect(page).to(have_content('Invalid Email or password'))
    end

    it 'signs in from signin page' do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      expect(page).to(have_current_path(dashboard_index_path, ignore_query: true))
    end

    it 'sends a forgot password email' do
      visit new_user_session_path
      click_link 'Forgot your password?'
      fill_in 'Email', with: user.email
      click_button 'Send me reset password instructions'
      expect(page).to(have_current_path(new_user_session_path, ignore_query: true))
      expect(page)
        .to(have_content('You will receive an email with instructions on how to reset your password in a few minutes.'))
      expect(ActionMailer::Base.deliveries.last.to).to(include(user.email))
      token = ActionMailer::Base.deliveries.last.body.raw_source.match(/reset_password_token=([^"]+)/)[1]

      # follow email line
      visit edit_user_password_path(reset_password_token: token)
      fill_in 'New password', with: ''
      fill_in 'Confirm new password', with: ''
      click_button 'Change my password'
      expect(page).to(have_content("Password can't be blank"))

      visit edit_user_password_path(reset_password_token: token)
      fill_in 'New password', with: 'funkynew'
      fill_in 'Confirm new password', with: 'funkynew'
      click_button 'Change my password'
      expect(user.reload.valid_password?('funkynew')).to(be(true))
    end

    it "doesn't send a forgot password email" do
      visit new_user_session_path
      click_link 'Forgot your password?'
      fill_in 'Email', with: 'weofij'
      click_button 'Send me reset password instructions'
      expect(page).to(have_current_path(user_password_path, ignore_query: true))
      expect(page).to(have_content('Email not found'))
      expect(ActionMailer::Base.deliveries).to(be_empty)
    end
  end
end
