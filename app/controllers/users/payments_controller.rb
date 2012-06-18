class Users::PaymentsController < Users::BaseController
  before_filter :find_wedding
  skip_before_filter :verify_authenticity_token, only: %w(success)

  def success
    if params[:payment_status] == "Completed"

      @wedding.update_attributes payment_made: true, payment_date: Time.now

      # Create a `transaction` - resembles double line accounting so we 
      # can make refunds etc.
      wedding_payment = @wedding.payments.create!({
        gross:            params[:mc_gross_1],
        transaction_fee:  fee(params[:mc_gross_1], params[:payment_gross], params[:payment_fee]),
        currency:         params[:mc_currency],
        transaction_id:   params[:txn_id],
        user_id:          current_user.id,
        gateway:          "PayPal",
        gateway_response: params
      })

      stationery_payment = @wedding.stationery.payments.create!({
        gross:            params[:mc_gross_2],
        transaction_fee:  fee(params[:mc_gross_2], params[:payment_gross], params[:payment_fee]),
        currency:         params[:mc_currency],
        transaction_id:   params[:txn_id],
        user_id:          current_user.id,
        gateway:          "PayPal",
        gateway_response: params
      })

      redirect_to redirect_url, notice: 'Payment made.'
    else
      redirect_to redirect_url, alert: 'Payment not made.'
    end
  end

  def failure
    redirect_to redirect_url, alert: 'Payment not made.'
  end

  protected

  def fee item, gross, fee
    ((item.to_f / gross.to_f) * fee.to_f).round(2)
  end

  def redirect_url
    wedding_confirm_path @wedding
  end
end
