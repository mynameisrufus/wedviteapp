module PagesHelper
  def preview_id
    @preview_id ||= 0
    @preview_id += 1
  end

  def stationery_previews
    [
      {
        imac: { url: "site/stationery1-imac.png", class: 'hidden-phone' },
        iphone: { url: "site/stationery1-iphone.png" }
      },
      {
        imac: { url: "site/stationery2-imac.png", class: 'hidden-phone' },
        iphone: { url: "site/stationery2-iphone.png" }
      }
    ]
  end
end
