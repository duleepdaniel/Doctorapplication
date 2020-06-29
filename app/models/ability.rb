# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
       if user.has_role? :admin
         can :manage, :all
       elsif user.has_role? :nurse
         can :read, Meeting
         cannot :read, Patient #, user_id: user.id
       elsif user.has_role? :doctor
        can :manage, :all
      else
        can :read,Meeting
       end
  end
end
