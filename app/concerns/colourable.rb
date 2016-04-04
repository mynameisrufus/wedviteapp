require 'color-generator'

module Colourable
  def color
    ColorGenerator.new(
      saturation: 0.7,
      value: 0.8,
      seed: created_at.to_i + id
    ).create_hex
  end
end
