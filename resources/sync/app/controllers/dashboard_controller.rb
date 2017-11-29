# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!, except: :welcome

  def welcome
    authorize :dashboard, :show?
    redirect_to :dashboard_index if current_user
  end

  def index
    policy_scope(:dashboard)
  end
end
