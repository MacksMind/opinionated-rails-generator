class AccountsController < ApplicationController
  before_filter :authenticate_user!
  skip_authorization_check

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "You updated your account successfully."
      redirect_to user_root_path
    else
      render :action => :edit
    end
  end
end
