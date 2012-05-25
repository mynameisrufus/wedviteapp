module WeddingsHelper
  def details_form &block
    form_for @wedding, url: wedding_update_details_path(@wedding), html: { class: 'form-horizontal' }, &block
  end
end
