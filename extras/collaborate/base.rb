class Collaborate::Base
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
