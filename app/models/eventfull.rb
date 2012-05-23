module Eventfull
  def self.included base
    base.has_many :evt, class_name: Event.to_s, as: :eventfull, dependent: :destroy
  end
end
