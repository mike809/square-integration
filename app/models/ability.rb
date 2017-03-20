class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      admin_abilities(user)
    else
      user_abilities(user)
    end
  end

  def user_abilities(user)
    can [:new, :create], SquareConnection
  end

  def admin_abilities(user)
    can :manage, :all
  end
end
