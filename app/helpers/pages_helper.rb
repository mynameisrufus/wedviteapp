module PagesHelper
  def preview_id
    @preview_id ||= 0
    @preview_id += 1
  end

  def stationery_previews
    [
      [
        { type: :imac, src: "stationery1-imac.png", css: 'span5 offset2 hidden-phone' },
        { type: :iphone, src: "stationery1-iphone.png", css: 'span4' }
      ],
      [
        { type: :imac, src: "stationery2-imac.png", css: 'span5 offset2 hidden-phone' },
        { type: :iphone, src: "stationery2-iphone.png", css: 'span4' }
      ]
    ]
  end

  def organise_previews
    [
      [
        { type: :imac, src: "organise1-imac.png", css: 'span6 visible-desktop' },
        { type: :imac, src: "organise2-imac.png", css: 'span6' }
      ]
    ]
  end
end
