class Ability
  include CanCan::Ability

  def initialize(collaboration)
    can [:send_invitations, :manage_collaborators], Wedding if collaboration.is_role?('invite')

    can :update, Wedding if %w(invite edit).include?(collaboration.role)

    can :comment, Guest if %w(invite edit comment).include?(collaboration.role)

    can :edit, Guest if %w(invite edit).include?(collaboration.role)

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
