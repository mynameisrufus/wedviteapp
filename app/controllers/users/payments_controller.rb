class Users::PaymentsController < Users::BaseController
  before_filter :find_wedding, except: %w(notify)
  skip_before_filter :verify_authenticity_token, only: %w(notify)
  skip_before_filter :authenticate_user!, only: %w(notify)

  def notify
    custom          = PayPal::CustomParamParser.new params[:custom]
    paypal_response = PayPal::Verify.new params, request.raw_post

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
