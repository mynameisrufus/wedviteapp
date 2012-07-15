class Users::PaymentsController < Users::BaseController
  before_filter :find_wedding, except: %w(notify)
  skip_before_filter :verify_authenticity_token, only: %w(notify)
  skip_before_filter :authenticate_user!, only: %w(notify)

  class PayPalVerify
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

  class PayPalCustomParamParser
    def initialize raw_param
      @raw  = raw_param
      @args = raw_param.split /,/
    end

    def wedding_id
      @args[0]
    end

    def user_id
      @args[1]
    end
  end

  def notify
    custom          = PayPalCustomParamParser.new params[:custom]
    paypal_response = PayPalVerify.new params, request.raw_post

    @wedding = Wedding.find custom.wedding_id

    if paypal_response.completed? && paypal_response.valid?

      wedding_paid!

      # Create a `transaction` - resembles double line accounting so we 
      # can make refunds etc.
      wedding_payment = @wedding.payments.create!({
        gross:            params[:mc_gross_1],
        transaction_fee:  fee(params[:mc_gross_1], params[:payment_gross], params[:payment_fee]),
        currency:         params[:mc_currency],
        transaction_id:   params[:txn_id],
        user_id:          custom.user_id,
        gateway:          "PayPal",
        gateway_response: params
      })

      stationery_payment = @wedding.stationery.payments.create!({
        gross:            params[:mc_gross_2],
        transaction_fee:  fee(params[:mc_gross_2], params[:payment_gross], params[:payment_fee]),
        currency:         params[:mc_currency],
        transaction_id:   params[:txn_id],
        user_id:          custom.user_id,
        gateway:          "PayPal",
        gateway_response: params
      })

    end

    head :ok
  end

  def success
    wedding_paid!
    redirect_to redirect_url, notice: 'Payment made.'
  end

  def failure
    redirect_to redirect_url, alert: 'Payment not made.'
  end

  protected

  def wedding_paid!
    @wedding.update_attributes payment_made: true, payment_date: Time.now
  end

  def fee item, gross, fee
    ((item.to_f / gross.to_f) * fee.to_f).round(2)
  end

  def redirect_url
    wedding_confirm_path @wedding
  end
end
