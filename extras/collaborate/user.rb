module Collaborate
  class User < Base
    def initialize(options = {})
      super options
      @wedding = options[:wedding]
      @user    = ::User.where(email: email).first
      @validators << proc(&method(:validate_user))
      @validators << proc(&method(:validate_token))
    end

    attr_accessor :wedding, :user, :collaboration_token, :collaborator

    def validate_user
      unless user.nil?
        if @wedding.users.include? @user
          errors.add :user, "is already collaborating on this wedding"
        end
      end
    end

    def validate_token
      if user.nil?
        @collaboration_token = ::CollaborationToken.create role: @role, wedding_id: @wedding.id, email: @email
        unless @collaboration_token.valid?
          @collaboration_token.errors.each do |attribute, errors_array|
            errors.add attribute, errors_array
          end
        end
      end
    end

    def do_invite
      mail = unless user.nil?
        @notify_sent = true
        @collaborator = ::Collaborator.create role: @role, wedding_id: @wedding.id, user: @user
        Users::Mailer.notify_collaborator requestor: @requestor,
                                          wedding: @wedding,
                                          user: @user,
                                          collaborator: @collaborator
      else
        @invite_sent = true
        Users::Mailer.invite_collaborator requestor: @requestor,
                                          wedding: @wedding,
                                          email: @email,
                                          token: @collaboration_token.token
      end
      mail.deliver
    end
  end
end
