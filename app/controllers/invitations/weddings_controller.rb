class Invitations::WeddingsController < Invitations::BaseController
  def our_day

  end

  def thank

  end

  def directions

  end

  def guestlist
    @guests = @wedding.guests.accepted.order(:name)
  end

  def ical
    calendar = RiCal.Calendar do |cal|
      cal.event &ceremony_event
      cal.event &reception_event if
        @wedding.has_reception? && @guest.attending_reception?
    end

    filename = @wedding.title.parameterize('_')

    send_data calendar.to_s, type: 'text/calendar',
                             disposition: "inline; filename=#{filename}.ics",
                             filename: "#{filename}.ics"
  end

  protected

  def ceremony_event
    proc do |event|
      event.summary = "#{@wedding.title} Ceremony"
      if @wedding.ceremony_when
        event.dtstart = @wedding.ceremony_when
        event.dtend = @wedding.ceremony_when_end if @wedding.ceremony_when_end
      end
      if @wedding.ceremony_where
        event.location = "#{@wedding.ceremony_where.name}, #{@wedding.ceremony_where.formatted_address}"
      end
      event.url = invitation_url @guest.token, subdomain: "invitations"
    end
  end

  def reception_event
    proc do |event|
      event.summary = "#{@wedding.title} Reception"
      if @wedding.reception_when
        event.dtstart = @wedding.reception_when
        event.dtend = @wedding.reception_when_end if @wedding.reception_when_end
      end
      if @wedding.reception_where
        event.location = "#{@wedding.reception_where.name}, #{@wedding.reception_where.formatted_address}"
      end
      event.url = invitation_url @guest.token, subdomain: "invitations"
    end
  end
end
