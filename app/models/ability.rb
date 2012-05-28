class Ability
  include CanCan::Ability

  def initialize(collaboration)
    can [:send_invitations, :manage_collaborators], Wedding do |wedding|
      wedding.collaborators.include?(collaboration) && collaboration.is_role?('invite')
    end

    can :update, Wedding do |wedding|
      wedding.collaborators.include?(collaboration) && %w(invite edit).include?(collaboration.role)
    end

    can :comment, Guest do |guest|
      guest.wedding.collaborators.include?(collaboration) && %w(invite edit comment).include?(collaboration.role)
    end

    can :edit, Guest do |guest|
      guest.wedding.collaborators.include?(collaboration) && %w(invite edit).include?(collaboration.role)
    end

    can :create, Guest if %w(invite edit).include?(collaboration.role)

    # Cannot delete or change another collaborators role if they have
    # the `invite` role as well.
    can :manage, Collaborator do |collaborator|
      collaborator.wedding == collaboration.wedding &&
      collaborator.is_not_role?('invite') &&
      collaboration.is_role?('invite')
    end
  end
end
