module StationeryRenderable

  module HumanDateTimeFilter
    def style datetime, index
      PrettyDate.style(datetime).with(index)
    rescue PrettyDate::MissingStyleError
      "That date and or time style does not exist"
    end
  end

  Liquid::Template.register_filter HumanDateTimeFilter

  class Attachement  < Liquid::Tag
    def initialize(tag_name, file_name, tokens)
       super
       @file_name = file_name.strip
    end

    def render context
      context.scopes.first[key][@file_name] ||
        "No #{key.to_s} with filename #{@file_name} could be found"
    end
  end

  class AssetTag < Attachement
    def key; :assets end
  end

  Liquid::Template.register_tag 'asset', AssetTag

  class ImageTag < Attachement
    def key; :images end
  end

  Liquid::Template.register_tag 'image', ImageTag

  class UrlDrop < Liquid::Drop
    attr_reader :accept, :decline

    def initialize accept_url, decline_url
      @accept  = accept_url
      @decline = decline_url
    end
  end

  # {{ wedding.has_reception }}
  class WeddingDrop < Liquid::Drop
    def initialize wedding
      @wedding = wedding
    end

    def name
      "#{@wedding.partner_one_name} & #{@wedding.partner_two_name}"
    end

    def initials
      "#{@wedding.partner_one_name[0]} & #{@wedding.partner_two_name[0]}"
    end
  end

  # {{ partner_one.name }}
  class PartnerDrop < Liquid::Drop
    def initialize name
      @name = name
    end

    def name
      @name
    end

    def initial
      @name[0]
    end
  end

  # {{ ceremony.when }}
  class CeremonyDrop < Liquid::Drop
    def initialize wedding
      @wedding = wedding
    end

    def start
      @wedding.ceremony_when
    end

    def finish
      @wedding.ceremony_when_end
    end
  end

  # {{ reception.when }}
  class ReceptionDrop < Liquid::Drop
    def initialize wedding
      @wedding = wedding
    end

    def start
      @wedding.reception_when
    end

    def finish
      @wedding.reception_when_end
    end
  end

  class GuestDrop < Liquid::Drop
    def initialize guest
      @guest = guest
    end

    def name
      @guest.name
    end

    def total
      adults + children
    end

    def adults
      @guest.adults
    end

    def children
      @guest.children
    end

    def token
      @guest.token
    end
  end

  def markdown
    WeddingInvitorMarkdown.new
  end

  def uploads_to_hash items
    items.inject({}) do |memo, item|
      memo.merge Hash[item.attachment_file_name, item.attachment]
    end
  end

  def uploads
    [:images, :assets].inject({}) do |memo, item|
      memo.merge Hash[item, uploads_to_hash(self.send(item))]
    end
  end

  # Convenience method called by render.
  def lq *args
    content = args.shift
    context = Liquid::Context.new args.shift, args.shift
    Liquid::Template.parse(content).render(context)
  end

  # Render the self with a guest.
  #
  # Renders the `content` (wedding wording) then passes this html to be 
  # rendered in the {{ content }} block of the template.

  def render_dev guest, accept_url = "#", decline_url = "#"
    render! guest, accept_url, decline_url, (self.html_dev || '')
  end

  def render guest, accept_url = "#", decline_url = "#"
    render! guest, accept_url, decline_url, (self.html || '')
  end

  def render! guest, accept_url, decline_url, template
    content  = markdown.render(guest.wedding.wording || '')
    drops    = HashWithIndifferentAccess.new({
      guest: GuestDrop.new(guest),
      wedding: WeddingDrop.new(guest.wedding),
      reception: ReceptionDrop.new(guest.wedding),
      ceremony: CeremonyDrop.new(guest.wedding),
      urls: UrlDrop.new(accept_url, decline_url),
      partner_one: PartnerDrop.new(guest.wedding.partner_one_name),
      partner_two: PartnerDrop.new(guest.wedding.partner_two_name)
    })

    lq(template, drops.merge(content: lq(content, drops)), uploads)
  end
end
