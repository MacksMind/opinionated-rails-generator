# frozen_string_literal: true

require 'rails_helper'

describe '/admin/users/new' do
  include Admin::UsersHelper

  before do
    assign(
      :user,
      stub_model(
        User,
        email: 'value for email',
        full_name: 'value for name'
      ).as_new_record { |u| u.stub(roles: []) }
    )
  end

  it 'renders new user form' do
    render

    assert_select 'form', action: admin_users_path, method: 'post' do
      assert_select 'input#user_email', name: 'user[email]'
      assert_select 'input#user_first_name', name: 'user[first_name]'
      assert_select 'input#user_last_name', name: 'user[last_name]'
    end
  end
end
