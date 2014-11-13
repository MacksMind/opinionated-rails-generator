class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :masquerade]

  respond_to :html

  def index
    @users = policy_scope(User)
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

  def edit
  end

  def create
    @user = User.new(user_params)
    authorize @user
    @user.save
    respond_with(:admin, @user)
  end

  def update
    params[:user].delete(:password) if user_params[:password].blank?
    params[:user].delete(:password_confirmation) if user_params[:password_confirmation].blank?
    @user.update(user_params)
    respond_with(@user, location: [:admin, @user])
  end

  def destroy
    @user.destroy
    respond_with(@user, location: [:admin, @user])
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
    params.require(:user).permit(:email,
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
                                 :country_id,
                                 :country_code,
                                 :roles => [])
  end
end
