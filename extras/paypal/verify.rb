module PayPal
  class Verify
    def initialize params, raw_post
      @params = params
      @raw    = raw_post
    end

    def valid?
      uri = URI.parse(PAYPAL[:url] + '/cgi-bin/webscr?cmd=_notify-validate')
      http = Net::HTTP.new uri.host, uri.port
      http.open_timeout = 60
      http.read_timeout = 60
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.use_ssl = true
      response = http.post(uri.request_uri, @raw,
                           'Content-Length' => "#{@raw.size}",
                           'User-Agent' => "Ruby Net::HTTP"
                         ).body

      raise StandardError.new("Faulty paypal result: #{response}") unless ["VERIFIED", "INVALID"].include?(response)
      raise StandardError.new("Invalid IPN: #{response}") unless response == "VERIFIED"

      true
    end

    def status
      @params[:payment_status]
    end

    def completed?
      status =~ /completed/i
    end
  end
end
