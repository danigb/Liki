class Ability
  include CanCan::Ability
  attr_reader :user, :space

  def initialize(user, space)
    @user = user
    @space = space
    node_abilities
  end

  def node_abilities
    space.is_open? ?
      can(:read, Node) :
      can(:read, Node) { member_required }
    can([:create, :update, :destroy], Node) { member_required }
  end

  protected
  def member_required
    space.member(user).present?
  end
end
