class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.present?
  end

  def destroy?
    return false unless user.present?
    record.user == user || record.idea.user == user || user.respond_to?(:admin?) && user.admin?
  end
end
