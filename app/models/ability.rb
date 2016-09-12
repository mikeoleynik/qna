class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      quest_abilities
    end
  end

  def quest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    quest_abilities

    alias_action  :create, :edit, :update, :destroy, to: :crud
    can :crud, [Question, Answer], user: user
    can :create, Comment

    can :me, User, id: user.id

    can :best, Answer, question: { user: user }

    can :create,  [Question, Answer, Comment, Subscription]

    can [:update, :destroy], [Question, Answer, Subscription], user_id: user.id

    can :manage, Attachment do |attachment|
      attachment.attachable.user_id == user.id
    end

    can [:up, :down], Vote do |vote|
      vote.votable.user_id != user.id
    end

    can :unvote, Vote, user: user
  end
end
