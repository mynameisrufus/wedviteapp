module Invitor
  class Base
    extend ActiveModel::Naming

    def initialize(options = {})
      @errors     = ActiveModel::Errors.new(self)
      @validators = [proc(&method(:validate_email))]
      @email      = options[:email]
      @role       = options[:role]
      @requestor  = options[:requestor]
    end

    attr_accessor :email, :role, :requestor
    attr_reader   :errors, :validators

    def save
      raise 'must be called from subclass'
    end

    def validate_email
      errors.add :email, "is not valid" unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    end

    def valid?
      validate!
      errors.empty?
    end
    
    def validate!
      validators.each do |validator|
        validator.call
      end
    end

    def save
      if valid?
        do_invite
        true
      else
        false 
      end
    end

    def read_attribute_for_validation(attr)
      send(attr)
    end

    def self.human_attribute_name(attr, options = {})
      attr
    end

    def self.lookup_ancestors
      [self]
    end

    def invite_sent?
      @invite_sent
    end

    def notify_sent?
      @notify_sent
    end
  end

  class Collaborator < Base

    def initialize(options = {})
      super options
      @wedding = options[:wedding]
      @user    = User.where(email: email).first
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
        @collaboration_token = CollaborationToken.create role: @role, wedding_id: @wedding.id, email: @email
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
