# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role?(:admin)
        scope.all
      else
        scope
      end
    end
  end

  def create?
    user.role?(:admin)
  end

  def update?
    user.role?(:admin) || user == record
  end

  def destroy?
    user.role?(:admin)
  end

  def masquerade?
    user.role?(:admin) && !record.role?(:admin)
  end
end
