class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role? :admin
      can :manage, :all
    else
      can :read, Channel do |channel|
        channel.user.include?(user)
      end
      
      can :update, Channel do |channel|
        channel.user.include?(user)
      end

      can :add_channel_to_user, Channel

      can :manage, Comment

      can :read, Feed do |feed|
        feed.channel.user.include?(user)
      end

      can :check_as_favourite, Feed do |feed|
        feed.channel.user.include?(user)
      end

      if user.role?(:basic)
        if user.channels.count < 10
          can :create, Channel
        end
      elsif user.role?(:medium)
          if user.channels.count < 20
            can :create, Channel
          end
      else user.role?(:premium)
        if user.channels.count < 100
          can :create, Channel
        end
      end

    end
  end

end