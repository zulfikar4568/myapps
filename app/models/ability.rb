# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(account)
    if account.admin?
      can :manage, :all
    elsif account.seller?
      can :read, Account
      can :read, Item
      can :create, Item
      can :update, Item do |item|
        item.try(:account) == account
      end
      can :destroy, Item do |item|
        item.try(:account) == account
      end
    elsif account.regular?
      can :read, Item
      can :read, Account
    end
  end
end
