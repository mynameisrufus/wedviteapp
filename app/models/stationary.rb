class Stationary < ActiveRecord::Base
  has_many :weddings
  has_many :stationary_images, dependent: :destroy
  has_many :stationary_assets, dependent: :destroy
  has_many :payments, as: :purchasable, dependent: :nullify
  belongs_to :agency

  validates_presence_of :style, :name
  validates_uniqueness_of :name
  validates :price, numericality: { greater_than_or_equal_to: 29.95 }
  validates :commision, numericality: true

  has_attached_file :preview,
    storage: :s3,
    s3_credentials: "#{Rails.root}/config/s3.yml",
    path: "stationary/:id/preview/:hash.:extension",
    hash_secret: "wedvitehash"

  scope :published, where(published: true)

  def render guest, wedding, accept_url = "#", decline_url="#"
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      autolink: true, space_after_headers: true)

    data = HashWithIndifferentAccess.new guest: GuestDrop.new(guest), wedding: WeddingDrop.new(guest.wedding), urls: UrlDrop.new(accept_url, decline_url)

    template = self.html
    content  = guest.wedding.wording || ''

    parsed_content = markdown.render(content)

    liquid = Liquid::Template.parse(parsed_content).render data

    Liquid::Template.parse(template).render data.merge('content' => liquid)
  end

  class UrlDrop < Liquid::Drop
    attr_reader :rsvp, :decline

    def initialize accept_url, decline_url
      @rsvp    = accept_url
      @decline = decline_url
    end
  end

  class WeddingDrop < Liquid::Drop
    def initialize wedding
      @wedding = wedding
    end

    def name
      @wedding.name
    end

    def title
      @wedding.title
    end

    def ceremony_when
      Time.now
    end

    def has_reception
      true
    end

    def reception_when
      Time.now
    end
  end

  class GuestDrop < Liquid::Drop
    def initialize guest
      @guest = guest
    end

    def name
      @guest.name
    end

    def adults
      rand 5
    end

    def children
      rand 5
    end

    def partner_number
      rand 1..2
    end

    def token
      @guest.token
    end
  end
end

module TextFilter
  # see
  # http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-ordinalize
  def flourished_date input
    "Saturday the Seventh of April Two Thousand and Twelve"
  end
end

Liquid::Template.register_filter TextFilter

