# frozen_string_literal: true

require 'rails_helper'

describe Admin::UsersHelper do
  # Delete this example and add some real ones or delete this file
  it 'is included in the helper object' do
    included_modules = (class << helper; self; end).public_send :included_modules
    expect(included_modules).to include(described_class)
  end
end
