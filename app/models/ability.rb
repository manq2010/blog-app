class Ability
  include CanCan::Ability

  def initialize(user)
    # Handle the case where we don't have a current_user i.e. the user is a guest
    # user ||= User.new

    # Define User abilities
    # if user.is? :admin
    #   can :manage, :all
    # else
    #   can :read, :create, :destroy, Post
    #   can :read, :create, :destroy, Comment
    # end

    # Define abilities for the user here. For example:
    #
    return unless user.present?

    # can :read, :create, :destroy, Post, author_id: user.id
    # can :read, :create, :destroy, Comment, author_id: user.id
    # can :manage, Like, author_id: user.id

    can :read, :all # everyone can read everything
    can :create, Comment # everyone can create comments
    can :create, Post # everyone can create comments
    can :destroy, Comment, author_id: user.id # users can delete their own comments
    can :destroy, Post, author_id: user.id # users can delete their own posts
    return unless user.admin?

    can :manage, :all
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
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end