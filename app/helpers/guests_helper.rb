module GuestsHelper
  def guest_form url, &block
    form_for @guest, url: url, html: { class: "form-horizontal modal-form" }, &block
  end
end
