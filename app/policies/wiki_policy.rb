class WikiPolicy < ApplicationPolicy
  def show?
    record.public? || user.present?
  end

  def make_private?
    user_role?('premium', 'admin')
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
     @user = user
     @scope = scope
    end

    def resolve
      Wiki.visible_to(user)
    end


  end
end