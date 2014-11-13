class ContentPolicy < Struct.new(:user, :content)
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
