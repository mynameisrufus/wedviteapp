class PromotionalCode < ActiveRecord::Base
  validates_presence_of :code, :limit, :discount, :expires_on
  validates_uniqueness_of :code

  class PromotionalCodeError < StandardError
    attr_reader :argument

    def initialize argument
      @argument = argument
    end
  end

  class InvalidCodeError < PromotionalCodeError
    def message
      "The promotional code #{argument} is invalid."
    end
  end

  class LimitExcededError < PromotionalCodeError
    def message
      "This promotional code is no longer valid because the limit of #{argument} has been reached."
    end
  end

  class ExpiredError < PromotionalCodeError
    def message
      "This promotional code is no longer valid because it expired on #{argument}."
    end
  end

  def self.claim code
    promo = where(code: code).first
    raise InvalidCodeError, code         if promo.nil?
    raise LimitExcededError, promo.limit if promo.limit_reached?
    raise ExpiredError, promo.expires_on if promo.expired?
    promo.claimed += 1
    promo.save
    promo
  end

  def limit_reached?
    self.claimed >= self.limit
  end

  def expired?
    self.expires_on <= Time.now
  end
end
