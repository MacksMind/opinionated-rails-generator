class PasswordResetsController < ApplicationController
  ssl_required :edit, :update
  before_filter :require_no_user
  before_filter :load_user_using_confirmation_token, :only => [:edit, :update]

  def new
    render
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = "Instructions to reset your password have been emailed to you. Please check your email."
      redirect_to sign_in_url
    else
      flash[:notice] = "No user was found with that email address"
      render :action => :new
    end
  end

  def edit
    render
  end

  def update
    if @user.update_password(params[:user][:password], params[:user][:password_confirmation])
      sign_in(@user)
      flash[:success] = "Password successfully updated"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  private
  def load_user_using_confirmation_token
    @user = User.find_by_confirmation_token(params[:id])
    unless @user
      flash[:notice] = "We're sorry, but that link is invalid or expired. Please try again."
      redirect_to :action => :new
    end
  end
end
