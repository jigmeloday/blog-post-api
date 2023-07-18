class CommentPolicy < ApplicationPolicy
  def destroy?
    user.id == record.user_id
  end

  def update?
    user.id == record.user_id
  end
end
