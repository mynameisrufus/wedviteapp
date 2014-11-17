class GuestState
  extend Enumerable

  State = Struct.new(:verb, :noun, :label, :title) do
    def to_s
      noun.to_s
    end
  end

  DICT = [
    State.new(
      :review,
      :review,
      "?",
      "For review"
    ),
    State.new(
      :thank,
      :thanked,
      "T",
      "Thanked"
    ),
    State.new(
      :accept,
      :accepted,
      "R",
      "RSVP"
    ),
    State.new(
      :sent,
      :sent,
      "&#64;",
      "Invitation sent"
    ),
    State.new(
      :approve,
      :approved,
      "&#10003;",
      "Approved for invitation"
    ),
    State.new(
      :tentative,
      :tentative,
      "&#8776;",
      "Tentative"
    ),
    State.new(
      :decline,
      :declined,
      "D",
      "Invitation declined"
    ),
    State.new(
      :reject,
      :rejected,
      "&#215;",
      "Rejected"
    )
  ]

  DICT.each do |state|
    define_singleton_method state.noun do
      state
    end
  end

  def self.by_noun(noun)
    DICT.detect{ |state| state.noun.to_s == noun.to_s }
  end

  def self.possibly_nouns
    [:tentative, :accepted, :sent, :approved]
  end

  def self.possibly
    DICT.select { |state| possibly_nouns.include?(state.noun) }
  end

  def self.likely_nouns
    [:accepted, :sent, :approved]
  end

  def self.likely
    DICT.select { |state| likely_nouns.include?(state.noun) }
  end

  def self.each(&block)
    DICT.each(&block)
  end
end
