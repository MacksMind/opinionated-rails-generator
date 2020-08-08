# frozen_string_literal: true

require 'rails_helper'

describe 'Accounts' do
  describe 'when signed in' do
    let(:user) { FactoryBot.create(:user) }

    before do
      sign_in(user)
    end

    it 'can update miscellaneous info' do
      visit edit_account_path
      fill_in 'Company', with: 'Central Supply'
      click_button 'Update'
      expect(page).to have_current_path(dashboard_index_path, ignore_query: true)
      expect(page).to have_content 'You updated your account successfully.'
      visit edit_account_path
      expect(find_field('Company').value).to eq('Central Supply')
    end
  end
end
