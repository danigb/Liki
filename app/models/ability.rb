class Ability
  include CanCan::Ability
  attr_reader :user, :space

  def initialize(user, space)
    @user = user
    @space = space
    basic_abilities
  end

  def basic_abilities
    models = [Node, Photo, PhotoTag]
    space.is_open? ?
      can(:read, models) :
      can(:read, models) { member_required }
    can([:create, :update, :destroy], models) { member_required }
  end

  protected
  def member_required
    space.member(user).present?
  end
end
