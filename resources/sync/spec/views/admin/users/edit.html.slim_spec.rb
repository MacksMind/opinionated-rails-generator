# frozen_string_literal: true

require 'rails_helper'

describe '/admin/users/edit' do
  include Admin::UsersHelper

  let(:user) do
    stub_model(
      User,
      id: SecureRandom.uuid,
      new_record?: false,
      email: 'value for email',
      full_name: 'value for name'
    ) { |u| u.roles = [] }
  end

  before { assign(:user, user) }

  it 'renders the edit user form' do
    render

    assert_select 'form', action: admin_user_path(user), method: 'post' do
      assert_select 'input#user_first_name', name: 'user[first_name]'
      assert_select 'input#user_last_name', name: 'user[last_name]'
    end
  end
end
