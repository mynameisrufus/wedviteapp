class Message < ActiveRecord::Base
  include Eventfull

  belongs_to :wedding
  belongs_to :messageable, dependent: :destroy, polymorphic: true
  has_many :replies

  validates_presence_of :text, :wedding_id, :messageable_id,
                        :messageable_type

  after_create do
    evt.create! wedding: wedding,
                state: 'new',
                headline: "#{messageable.name} wrote:"
  end

  class Participants
    attr_reader :message, :users, :guests

    def initialize message, guests = [], users = []
      @message = message
      @users   = users
      @guests  = guests.select{ |guest| guest.accepted? }
      collect
      reject
    end

    def not messageable
      @guests.delete messageable
      @users.delete messageable
      self
    end

    protected

    def collect
      case @message.messageable_type
      when 'User' then @users << @message.messageable
      when 'Guest' then @guests << @message.messageable
      end
      @message.replies.each do |reply|
        case reply.replyable_type
        when 'User' then @users << reply.replyable
        when 'Guest' then @guests << reply.replyable
        end
      end
    end

    # If a guest declines an invitation or gets rejected then they
    # should no longer be considered a participant.
    #
    # Also reject users that are no longer collaborators on the wedding.
    def reject
      @guests.select! do |guest|
        guest.accepted?
      end

      @users.select! do |user|
        @message.wedding.users.include? user
      end
    end
  end

  def participants
    Participants.new self
  end

  def by? type
    messageable_type == type.to_s.humanize
  end
end
