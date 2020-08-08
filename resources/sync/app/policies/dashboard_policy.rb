# frozen_string_literal: true

# rubocop:disable Style/StructInheritance
class DashboardPolicy < Struct.new(:user, :dashboard)
  # rubocop:enable Style/StructInheritance
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve; end
  end

  def show?
    true
  end
end
