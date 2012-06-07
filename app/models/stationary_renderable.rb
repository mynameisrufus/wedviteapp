module StationaryRenderable

  module TextFilter
    # see
    # http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-ordinalize
    def flourished_date input
      "Saturday the Seventh of April Two Thousand and Twelve"
    end
  end

  Liquid::Template.register_filter TextFilter

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

  def markdown
    Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      autolink: true, space_after_headers: true)
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
  def render guest, accept_url = "#", decline_url = "#"
    template = self.html || ''
    content  = markdown.render(guest.wedding.wording || '')
    drops    = HashWithIndifferentAccess.new guest: GuestDrop.new(guest),
                                             wedding: WeddingDrop.new(guest.wedding),
                                             urls: UrlDrop.new(accept_url, decline_url)

    lq(template, drops.merge(content: lq(content, drops)), uploads)
  end
end
