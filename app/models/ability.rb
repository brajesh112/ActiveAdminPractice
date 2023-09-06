class Ability
  include CanCan::Ability
  include ActiveAdminRole::CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new

    if user.super_user?
      can :manage, :all
    end
    if user.guest_user?
      can :read, :all
      cannot :read, Label
      # register_role_based_abilities(user)
    end
    if user.role.eql?("manager")
      can [:read, :update], :all
    end
    # NOTE: Everyone can read the page of Permission Deny
    can :read, ActiveAdmin::Page, name: "Dashboard"
  end
end
