# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_role?(:admin)
        scope.all
      else
        scope
      end
    end
  end

  def create?
    user.has_role?(:admin)
  end

  def update?
    user.has_role?(:admin) || user == record
  end

  def destroy?
    user.has_role?(:admin)
  end

  def masquerade?
    user.has_role?(:admin) && !record.has_role?(:admin)
  end
end
