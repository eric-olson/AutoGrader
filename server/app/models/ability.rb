class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == "admin"
      # admin stuff
      can :manage, :all
    elsif user.role == "ta"
      # TA stuff
      can :read, Lab
      can :grades, Lab
      can :read, Assignment
      can :grades, Assignment
      can :testCode, Assignment
      can :saveCode, Assignment
      can :restartCode, Assignment
      can :uploadCode, Assignment
      can :downloadCode, Assignment
      can :submitCode, Assignment
      can :read, User
      can :index, User
      can :manage, Grade
      can :read, Static
    else
      # Student stuff
      can :read, Lab
      can :read, Assignment
      can :testCode, Assignment
      can :saveCode, Assignment
      can :restartCode, Assignment
      can :uploadCode, Assignment
      can :downloadCode, Assignment
      can :submitCode, Assignment
      can :read, User, :id => user.id
      can :read, Static
      cannot :index, User
      cannot :index, Assignment
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
