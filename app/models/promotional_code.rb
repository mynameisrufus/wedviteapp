class PromotionalCode < ActiveRecord::Base
  validates_presence_of :code, :limit, :discount, :expires_on
  validates_uniqueness_of :code

  class InvalidCodeError < StandardError
    def initialize code
      @message = "The promotional code #{code} is invalid."
    end
  end

  class LimitExcededError < StandardError
    def initialize limit
      @message = "This promotional code is no longer valid because the limit of #{limit} has been reached."
    end
  end

  class ExpiredError < StandardError
    def initialize expires_on
      @message = "This promotional code is no longer valid because it expired on #{expires_on}."
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
