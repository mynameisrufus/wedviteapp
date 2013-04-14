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
    sh = get_state_hash state
    html_options = {
      class: ["state", "icon", state],
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
    @guest_array ||= state_hash.sort do |x, y|
      x[:order] <=> y[:order]
    end.map do |sh|
      guests = @guests.select do |g|
        g.state == sh[:state]
      end.sort do |x, y|
        x[:position].to_i <=> y[:position].to_i
      end
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

  def total_guests
    @guests.select do |guest|
      guest.likely?
    end.inject(2) do |memo, sym|
      memo + sym.total_guests
    end
  end

  def total_possible_guests
    @guests.select do |guest|
      guest.possibly?
    end.inject(2) do |memo, sym|
      memo + sym.total_guests
    end
  end

  def total_guests_partner num
    @guests.select do |guest|
      guest.partner_number == num && guest.likely?
    end.inject(1) do |memo, sym|
      memo + sym.total_guests
    end
  end

  def state_hash
    [
      {
        state: "review",
        label: "?",
        title: "For review",
        order: 1
      },
      {
        state: "thanked",
        label: "T",
        title: "Thanked",
        order: 2
      },
      {
        state: "accepted",
        label: "R",
        title: "RSVP",
        order: 3
      },
      {
        state: "sent",
        label: "&#64;",
        title: "Invitation sent",
        order: 4
      },
      {
        state: "approved",
        label: "&#10003;",
        title: "Approved for invitation",
        order: 5
      },
      {
        state: "tentative",
        label: "&#8776;",
        title: "Tentative",
        order: 6
      },
      {
        state: "declined",
        label: "D",
        title: "Invitation declined",
        order: 7
      },
      {
        state: "rejected",
        label: "&#215;",
        title: "Rejected",
        order: 8
      },
      {
        state: "default",
        label:   "-",
        title: "unknown",
        order: 0
      }
    ]
  end

  def nav_tab title, url
    content_tag :li, class: (current_page?(url) ? 'active' : nil) do
      link_to title, url
    end
  end
end
