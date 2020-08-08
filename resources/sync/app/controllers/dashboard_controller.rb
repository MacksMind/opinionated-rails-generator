# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!, except: :welcome

  def welcome
    authorize :dashboard, :show?
    if current_user
      redirect_to :dashboard_index
    elsif params[:email].present?
      redir_params = { user: { email: params[:email] } }
      redirect_to(
        if User.exists?(email: params[:email])
          new_user_session_path(redir_params)
        else
          new_user_registration_path(redir_params)
        end
      )
    end
  end

  def index
    policy_scope(:dashboard)
  end
end
