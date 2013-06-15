class Ability
  include CanCan::Ability
  attr_reader :user, :space

  def initialize(user, space)
    @user = user
    @space = space
    basic_abilities
    if user
      user_abilities
      admin_abilities if user.admin?
    end
  end

  def basic_abilities
    models = [Node, Photo, PhotoTag]
    space.is_open? ?
      can(:read, models) :
      can(:read, models) { member_required }
    can([:create, :update, :destroy], models) { member_required }
  end

  def user_abilities
    can [:edit, :destroy], Comment, user_id: user.id
  end

  def admin_abilities
    can :manage, Comment
  end

  protected
  def member_required
    space.member(user).present?
  end
end
