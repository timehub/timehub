class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all

    elsif user.persisted? # Normal logged-in user.
      can :manage, Project, :user_id => user.id
      can :manage, Invoice, :project_id => user.project_ids
      can :manage, Commit, :project_id => user.project_ids

    else # Nobody's logged in
      # can :fuck_off
    end
  end
end
