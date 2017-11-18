# frozen_string_literal: true

class DashboardPolicy < Struct.new(:user, :dashboard)
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
    end
  end

  def show?
    true
  end
end
