class Location < ActiveRecord::Base
  serialize :address_components
  serialize :types

  def new(attributes)
    super parse_escaped_json(attributes)
  end

  def update_attributes(attributes)
    super parse_escaped_json(attributes)
  end

  def parse_escaped_json(attributes)
    attributes[:address_components] = JSON.parse attributes.delete(:address_components)
    attributes[:types]              = JSON.parse attributes.delete(:types)
    attributes
  end
end
