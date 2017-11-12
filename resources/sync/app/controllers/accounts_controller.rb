class AccountsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
    authorize @user
  end

  def update
    @user = current_user
    authorize @user
    if @user.update_attributes(user_params)
      flash[:success] = "You updated your account successfully."
      redirect_to signed_in_root_path
    else
      render action: :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name,
                                   :last_name,
                                   :time_zone,
                                   :phone_number,
                                   :company_name,
                                   :title,
                                   :address_line_1,
                                   :address_line_2,
                                   :city,
                                   :state_id,
                                   :postal_code,
                                   :country_id)
    end
end
