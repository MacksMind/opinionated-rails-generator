# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::UsersController do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  let(:valid_attributes) do
    {
      email: 'foo@example.com',
      password: 'foobar12',
      first_name: 'Jimmy',
      last_name: 'Stewart',
      time_zone: 'Eastern Time (US & Canada)',
      company_name: 'ACME',
      phone_number: '123-456-7890',
      address_line_1: '123 E Main St',
      city: 'Anytown',
      state_code: 'NY',
      postal_code: '12345',
      country_code: 'US'
    }
  end

  let(:invalid_attributes) do
    { email: 'foo' }
  end

  let(:valid_session) { {} }

  before do
    sign_in(admin_user)
  end

  describe 'GET index' do
    it 'assigns all users as @users' do
      user = User.create! valid_attributes
      get :index
      expect(assigns(:users)).to match_array [admin_user, user]
    end
  end

  describe 'GET show' do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      get :show, params: { id: user.to_param }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET new' do
    it 'assigns a new user as @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      get :edit, params: { id: user.to_param }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new User' do
        expect { post :create, params: { user: valid_attributes } }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, params: { user: valid_attributes }
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it 'redirects to the created user' do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to([:admin, User.order(created_at: :desc).first])
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved user as @user' do
        post :create, params: { user: invalid_attributes }
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, params: { user: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) do
        { phone_number: '12345' }
      end

      it 'updates the requested user' do
        user = User.create! valid_attributes
        put :update, params: { id: user.to_param, user: new_attributes }
        user.reload
        expect(user.phone_number).to eq('12345')
      end

      it 'assigns the requested user as @user' do
        user = User.create! valid_attributes
        put :update, params: { id: user.to_param, user: valid_attributes }
        expect(assigns(:user)).to eq(user)
      end

      it 'redirects to the user' do
        user = User.create! valid_attributes
        put :update, params: { id: user.to_param, user: valid_attributes }
        expect(response).to redirect_to([:admin, user])
      end
    end

    describe 'with invalid params' do
      it 'assigns the user as @user' do
        user = User.create! valid_attributes
        put :update, params: { id: user.to_param, user: invalid_attributes }
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        user = User.create! valid_attributes
        put :update, params: { id: user.to_param, user: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested user' do
      user = User.create! valid_attributes
      expect { delete :destroy, params: { id: user.to_param } }.to change { User.active.count }.by(-1)
    end

    it 'redirects to the users list' do
      user = User.create! valid_attributes
      delete :destroy, params: { id: user.to_param }
      expect(response).to redirect_to(admin_users_url)
    end
  end
end
