# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authorize_dashboard, except: :index

  def index
    policy_scope(:dashboard)
  end

  def authorize_dashboard
    authorize :dashboard, :show?
  end
end
