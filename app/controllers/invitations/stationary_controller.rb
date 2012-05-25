module TextFilter
  # see
  # http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-ordinalize
  def flourished_date input
    "Saturday the Seventh of April Two Thousand and Twelve"
  end
end

Liquid::Template.register_filter TextFilter

class Invitations::StationaryController < Invitations::BaseController
  layout false

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

  def show
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        :autolink => true, :space_after_headers => true)
    @guest = Guest.find_by_token params[:token];

    if @guest.accepted? || @guest.declined?
      redirect_to guesthome_path
    else
      data = HashWithIndifferentAccess.new guest: GuestDrop.new(@guest), wedding: WeddingDrop.new(@guest.wedding)

      template = @guest.wedding.stationary.html
      content  = @guest.wedding.wording || ''

      parsed_content = markdown.render(content)

      liquid = Liquid::Template.parse(parsed_content).render data

      lq = Liquid::Template.parse(template).render data.merge('content' => liquid)
      render inline: lq
    end
  end
end
