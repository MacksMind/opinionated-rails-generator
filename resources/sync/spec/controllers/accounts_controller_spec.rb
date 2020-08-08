# frozen_string_literal: true

require 'rails_helper'

describe AccountsController do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in(user)
  end

  def valid_attributes
    { first_name: 'Joe', last_name: 'Smith' }
  end

  describe 'GET edit' do
    it 'assigns the current user as @user' do
      get :edit
      expect(assigns(:user)).to(eq(user))
    end

    it 'still works with an invalid user' do
      # rubocop:disable Rails/SkipsModelValidations
      user.update_attribute(:first_name, nil)
      # rubocop:enable Rails/SkipsModelValidations
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the current user' do
        # Assuming there are no other users in the database, this
        # specifies that the User created by the factory
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(User).to(receive(:update).with('first_name' => 'params'))
        put :update, params: { user: { first_name: 'params' } }
      end

      it 'assigns the current user as @user' do
        put :update, params: { user: valid_attributes }
        expect(assigns(:user)).to(eq(user))
      end

      it 'redirects to root' do
        put :update, params: { user: valid_attributes }
        expect(response).to(redirect_to(dashboard_index_path))
      end
    end

    describe 'with invalid params' do
      it 'assigns the current as @user' do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(User).to(receive(:save).and_return(false))
        put :update, params: { user: { invalid: 'invalid' } }
        expect(assigns(:user)).to(eq(user))
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(User).to(receive(:save).and_return(false))
        put :update, params: { user: { invalid: 'invalid' } }
        expect(response).to(render_template('edit'))
      end
    end
  end
end
