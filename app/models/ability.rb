# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    can :create, Nippo
    can :update, Nippo, user_id: user.id
    can :read,   Nippo, sent?: true
    can :read,   Nippo, user_id: user.id
  end
end
