class Ability
  include CanCan::Ability
  attr_reader :user, :space

  def initialize(user, space)
    @user = user
    @space = space
    node_abilities
  end

  def node_abilities
    if space.is_open?
      can :read, Node
    else
      can(:read, Node) { member_required }
    end
    can([:create, :update, :destroy], Node) { member_required }
  end

  protected
  def member_required
    space.member(user).present?
  end
end
