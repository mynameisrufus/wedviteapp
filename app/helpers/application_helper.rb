module ApplicationHelper
  def error_messages_on(object)
    if object.errors.any?
      errors_count = pluralize object.errors.count, "error"
      errors_text  = "You request could not be completed because of the following"
      content_tag :div, class: 'errors' do
        content_tag(:h2, "#{errors_text} #{errors_count}:") +
        content_tag(:ul) do
          object.errors.full_messages.map do |message|
            content_tag(:li, message)
          end.join.html_safe
        end
      end
    end
  end

  def state_icon(state)
    html_options = {
      class: ["state", "icon", state.noun],
      title: state.title,
      rel: 'twipsy'
    }
    content_tag :span, state.label, html_options, false
  end

  def nav_tab title, url
    content_tag :li, class: (current_page?(url) ? 'active' : nil) do
      link_to title, url
    end
  end
end
