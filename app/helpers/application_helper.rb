module ApplicationHelper
  def error_messages_on(object)
    if object.errors.any?
      errors_count = pluralize @wedding.errors.count, "error"
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
    sh = get_state_hash state
    html_options = {
      class: ["state", "icon", sh[:css]],
      title: sh[:title],
      rel: 'twipsy'
    }
    content_tag :span, sh[:label], html_options, false
  end

  def get_state_hash(state)
    sh = state_hash.detect do |sh|
      sh[:state] == state
    end
    sh.nil? ? state_hash.last : sh
  end

  def guest_array
    state_hash.sort do |x, y|
      x[:order] <=> y[:order]
    end.map do |sh|
      guests = @guests.select{|g| g.state == sh[:state]}
      sh.merge guests: guests,
                stats: stats(guests)
    end
  end

  def stats(set)
    stat(set).merge partner_one: stat(set.select{|g| g.partner_number == 1}),
                    partner_two: stat(set.select{|g| g.partner_number == 2})
  end

  def stat(set)
    {
      total: set.inject(0) do |memo, sym|
        memo + sym[:adults] + sym[:children]
      end,
      adults: set.inject(0) do |memo, sym|
        memo + sym[:adults]
      end,
      children: set.inject(0) do |memo, sym|
        memo + sym[:children]
      end
    }
  end

  def state_hash
    [
      {
        state: "review",
        label: "?",
        title: "Suggested",
        css:   "silver",
        color: "#57A957",
        order: 3
      },
      {
        state: "approved",
        label: "&#10003;",
        title: "Approved for invitation",
        css:   "green",
        color: "#57A957",
        order: 4
      },
      {
        state: "rejected",
        label: "&#215;",
        title: "Rejected",
        css:   "red",
        color: "#C43C35",
        order: 5
      },
      {
        state: "tentative",
        label: "&#8776;",
        title: "Tentative",
        css:   "aqua",
        color: "#339BB9",
        order: 6
      },
      {
        state: "accepted",
        label: "R",
        title: "RSVP",
        css:   "gold",
        color: "silver",
        order: 1
      },
      {
        state: "declined",
        label: "D",
        title: "Invitation declined",
        css:   "black",
        color: "#000000",
        order: 2
      },
      {
        state: "sent",
        label: "&#64;",
        title: "Invitation sent",
        css:   "black",
        color: "#000000",
        order: 2
      },
      {
        state: "default",
        label:   "-",
        title: "unknown",
        css:   "unknown",
        color: "pink",
        order: 0
      }
    ]
  end
end
