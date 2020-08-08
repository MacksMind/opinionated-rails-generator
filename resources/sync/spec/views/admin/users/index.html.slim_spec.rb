# frozen_string_literal: true

require 'rails_helper'

describe '/admin/users/index' do
  include Admin::UsersHelper

  before do
    assign(:q, User.ransack)
    assign(
      :users,
      Kaminari.paginate_array(
        [
          stub_model(
            User,
            id: SecureRandom.uuid,
            email: 'value for email',
            first_name: 'value for first name',
            last_name: 'value for last name'
          ) { |u| u.roles = [] },
          stub_model(
            User,
            id: SecureRandom.uuid,
            email: 'value for email',
            first_name: 'value for first name',
            last_name: 'value for last name'
          ) { |u| u.roles = [] }
        ]
      ).page(1)
    )
  end

  it 'renders a list of users' do
    render
    expect(rendered).to have_selector 'tr>td', text: 'value for first name', count: 2
    expect(rendered).to have_selector 'tr>td', text: 'value for last name', count: 2
    expect(rendered).to have_selector 'tr>td', text: 'value for email', count: 2
  end
end
