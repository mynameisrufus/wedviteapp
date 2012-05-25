module WeddingsHelper
  def details_form &block
    form_for @wedding, url: wedding_update_details_path(@wedding), html: { class: 'form-horizontal' }, &block
  end

  def invitations_form &block
    form_for @wedding, url: wedding_update_invitations_path(@wedding), html: { class: 'form-horizontal' }, &block
  end
end
