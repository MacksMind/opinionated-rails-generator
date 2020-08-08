# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy masquerade]

  respond_to :html

  def index
    @q = policy_scope(User).active.ransack(params[:q])
    @q.sorts = %w[first_name last_name] if @q.sorts.empty?
    @users = @q.result.page(params[:page])
    respond_with(@users)
  end

  def show
    respond_with(@user, template: 'shared/user')
  end

  def new
    @user = User.new
    authorize @user
    respond_with(@user)
  end

  def edit; end

  def create
    @user = User.new(user_params)
    authorize @user
    # rubocop:disable Rails/SaveBang
    @user.save
    # rubocop:enable Rails/SaveBang
    respond_with(:admin, @user)
  end

  def update
    params[:user].delete(:password) if user_params[:password].blank?
    params[:user].delete(:password_confirmation) if user_params[:password_confirmation].blank?
    # rubocop:disable Rails/SaveBang
    @user.update(user_params)
    # rubocop:enable Rails/SaveBang
    respond_with(@user, location: [:admin, @user])
  end

  def destroy
    @user.cancel
    redirect_to action: :index
  end

  def masquerade
    sign_in @user
    redirect_to signed_in_root_path
  end

private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :time_zone,
      :phone_number,
      :company_name,
      :title,
      :address_line_1,
      :address_line_2,
      :city,
      :state_id,
      :state_code,
      :postal_code,
      :country_code,
      roles: []
    )
  end
end
