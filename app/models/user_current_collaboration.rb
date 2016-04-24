class UserCurrentCollaboration
  def initialize(user, wedding_id)
    @user = user
    @wedding_id = wedding_id
  end

  def get
    by_wedding_id || by_current || by_first || by_new_wedding
  end

  def by_wedding_id
    collaboration = @user.collaborations.where(wedding_id: @wedding_id).first
    return unless collaboration
    ensure_current_collaboration(collaboration)
    collaboration
  end

  def by_current
    collaboration = @user.collaborator
    return unless collaboration
    collaboration
  end

  def by_first
    collaboration = @user.collaborations.first
    return unless collaboration
    ensure_current_collaboration(collaboration)
    collaboration
  end

  def by_new_wedding
    wedding = Wedding.new(name: 'Our wedding')
    wedding.save!
    wedding.evt.create!(
      wedding: wedding,
      headline: "#{@user.name} created a wedding on WedVite!"
    )
    collaboration = wedding.collaborators.create!(
      wedding: wedding,
      user: @user,
      role: 'invite'
    )
    ensure_current_collaboration(collaboration)
    collaboration
  end

  private

  def ensure_current_collaboration(collaboration)
    return if collaboration.id == @user.collaborator_id
    @user.update_attribute(:collaborator_id, collaboration.id)
  end
end
