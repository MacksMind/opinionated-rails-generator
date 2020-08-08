# frozen_string_literal: true

require 'rails_helper'

describe AccountsController do
  describe 'routing' do
    it 'routes to #edit' do
      expect(get('/account/edit')).to route_to('accounts#edit')
    end

    it 'routes to #update' do
      expect(put('/account')).to route_to('accounts#update')
    end
  end
end
