# frozen_string_literal: true

require 'rails_helper'

describe 'Admin/Users' do
  let(:admin_user) { FactoryBot.create(:admin_user, password: 'testing1') }
  let(:user)       { FactoryBot.create(:user)                             }

  before do
    sign_in(admin_user)
  end

  it 'creates a new user' do
    visit new_admin_user_path
    fill_in 'Email', with: 'new_user@example.com'
    fill_in 'First name', with: 'Joe'
    fill_in 'Last name', with: 'Blow'
    fill_in 'user_password', with: 'asecret1'
    fill_in 'Password confirmation', with: 'asecret1'
    fill_in 'Phone number', with: 'BR549'
    fill_in 'Company name', with: 'State Lunatic Hospital'
    fill_in 'Title', with: 'Inmate'
    fill_in 'Address line 1', with: 'Kirkbride Building'
    fill_in 'Address line 2', with: '450 Maple St'
    fill_in 'City', with: 'Danvers'
    select 'Massachusetts', from: 'State/Province'
    fill_in 'Postal code', with: '01923'
    select 'UNITED STATES', from: 'Country'
    check 'Admin'
    click_button 'Create'
    expect(page).to have_content 'new_user@example.com'
    expect(page).to have_content 'Joe Blow'
    expect(page).to have_content 'BR549'
    expect(page).to have_content 'State Lunatic Hospital'
    expect(page).to have_content 'Inmate'
    expect(page).to have_content 'Kirkbride Building'
    expect(page).to have_content '450 Maple St'
    expect(page).to have_content 'Danvers MA 01923'
    expect(page).to have_content 'UNITED STATES'
    expect(page).to have_content 'admin'
    click_link 'Edit'
    fill_in 'First name', with: 'Jane'
    fill_in 'Last name', with: 'Doe'
    fill_in 'user_password', with: 'new secret'
    fill_in 'Password confirmation', with: 'new secret'
    click_button 'Update'
    expect(page).to have_content 'Jane Doe'
  end

  it 'allows masquerade' do
    # Instantiate user
    user
    visit admin_users_path
    within("##{dom_id(user)}") do
      click_link 'Masq'
    end
    expect(page).to have_current_path(dashboard_index_path, ignore_query: true)
    expect(page).to have_content user.email
  end
end
