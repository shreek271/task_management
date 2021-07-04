class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def show?
    user.id == record.user_id
  end

  def edit?
    user.id == record.user_id
  end

  def update?
    user.id == record.user_id
  end

  def mark_inprogress?
    user.id == record.user_id
  end

  def mark_done?
    user.id == record.user_id
  end
end