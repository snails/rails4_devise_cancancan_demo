class Ability
  include CanCan::Ability

  def initialize(user)
    #Not login
    if user.blank?
      cannot :mannage, :all
      basic_read_only

    elsif user.has_role?(:admin)  
      #Admin
      can :manage, :all 
    else user.has_role?(:owner)
      can [:create, :read], [Post, Comment]
      can :update, Post do |post|
        post.user_id == user.id || user.admin?
      end
      can :destroy, Post do |post|
        post.user_id == user.id || user.admin?
      end
    end
  end

  private
  def basic_read_only
    puts "************Basic READ ONLY*********"
    can :read, Post
    can :read, Comment
  end
end
