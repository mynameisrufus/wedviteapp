# http://www.codyfauser.com/2008/1/17/paypal-express-payments-with-activemerchant
# http://railscasts.com/episodes/146-paypal-express-checkout
#
# Form tag api:
#   https://merchant.paypal.com/us/cgi-bin/?cmd=_render-content&content_ID=developer/e_howto_html_Appx_websitestandard_htmlvariables
#
# Response codes:
#
#   https://merchant.paypal.com/us/cgi-bin/?cmd=_render-content&content_ID=developer/e_howto_html_IPNandPDTVariables
#
# Sandbox:
#   https://developer.paypal.com/
#
# Sandbox buyer:
#   email:    rufusp_1337563233_per@gmail.com
#   password: 337566419
#
#
# Sandbox seller:
#   email:    rufusp_1337563286_biz@gmail.com
#   password: 337563044

# IPN example
#  mc_gross=19.95
#  &protection_eligibility=Eligible
#  &address_status=confirmed
#  &payer_id=LPLWNMTBWMFAY
#  &tax=0.00&address_street=1+Main+St
#  &payment_date=20%3A12%3A59+Jan+13%2C+2009+PST
#  &payment_status=Completed
#  &charset=windows-1252
#  &address_zip=95131
#  &first_name=Test
#  &mc_fee=0.88
#  &address_country_code=US
#  &address_name=Test+User&notify_version=2.6
#  &custom=
#  &payer_status=verified
#  &address_country=United+States
#  &address_city=San+Jose
#  &quantity=1
#  &verify_sign=AtkOfCXbDm2hu0ZELryHFjY-Vb7PAUvS6nMXgysbElEn9v-1XcmSoGtf
#  &payer_email=gpmac_1231902590_per%40paypal.com
#  &txn_id=61E67681CH3238416
#  &payment_type=instant
#  &last_name=User
#  &address_state=CA
#  &receiver_email=gpmac_1231902686_biz%40paypal.com
#  &payment_fee=0.88
#  &receiver_id=S8XGHLYDW9T3S
#  &txn_type=express_checkout
#  &item_name=
#  &mc_currency=USD
#  &item_number=
#  &residence_country=US
#  &test_ipn=1
#  &handling_amount=0.00
#  &transaction_subject=
#  &payment_gross=19.95
#  &shipping=0.00

if Rails.env.test?
  PAYPAL_FIXTURES = {
    ipn: HashWithIndifferentAccess.new({
      "mc_gross"=>"79.90",
      "protection_eligibility"=>"Ineligible",
      "item_number1"=>"",
      "item_number2"=>"",
      "payer_id"=>"E2Y8P6JQF2WKL",
      "tax"=>"0.00",
      "payment_date"=>"21:43:30 Jun 17, 2012 PDT",
      "payment_status"=>"Completed",
      "charset"=>"windows-1252",
      "mc_shipping"=>"0.00",
      "mc_handling"=>"0.00",
      "first_name"=>"Rufus",
      "mc_fee"=>"3.02",
      "notify_version"=>"3.4",
      "custom"=>"",
      "payer_status"=>"verified",
      "business"=>"rufusp_1337563286_biz@gmail.com",
      "num_cart_items"=>"2",
      "mc_handling1"=>"0.00",
      "mc_handling2"=>"0.00",
      "payer_email"=>"rufusp_1337563233_per@gmail.com",
      "verify_sign"=>"Au1-ULy2TUriM5IYrE7p173qvLhVAg1ILqBq2455CSaq2CfnEwrR1YX0",
      "mc_shipping1"=>"0.00",
      "mc_shipping2"=>"0.00",
      "tax1"=>"0.00",
      "tax2"=>"0.00",
      "txn_id"=>"1M298731UG0277217",
      "payment_type"=>"instant",
      "last_name"=>"Post",
      "item_name1"=>"Plan Payment",
      "receiver_email"=>"rufusp_1337563286_biz@gmail.com",
      "item_name2"=>"Stationery",
      "payment_fee"=>"3.02",
      "quantity1"=>"1",
      "quantity2"=>"1",
      "receiver_id"=>"XY6RBJSDPVAUS",
      "txn_type"=>"cart",
      "mc_gross_1"=>"49.95",
      "mc_currency"=>"USD",
      "mc_gross_2"=>"29.95",
      "residence_country"=>"US",
      "test_ipn"=>"1",
      "transaction_subject"=>"Shopping CartPlan PaymentStationery",
      "payment_gross"=>"79.90",
      "wedding_id"=>"1"
    })
  }
end

require 'paypal/custom_param_parser'
require 'paypal/verify'

# setup_response = gateway.setup_purchase(200,
#   :ip                => request.remote_ip,
#   :items => [{:name => "Tickets", :quantity => 22, :description => "Tickets for 232323", :amount => 10}],
#   :return_url        => url_for(:action => 'confirm', :only_path => false),
#   :cancel_return_url => url_for(:action => 'index', :only_path => false),
#   :notify_url => ''
# )
# redirect_to gateway.redirect_url_for(setup_response.token)

# API Username  rufuspost_api1.gmail.com
# API Password  3TEFRMFY9ERMNBGD
# Signature A.V6N9Rr7oPKJhqpELqCh7qtMpfAAL-iBM0NRTdAwn3ZAKlgaqF.0yfk
# Request Date  19 Jul 2012 16:43:18 AEST

PAYPAL = {
  development: {
    url: "https://www.sandbox.paypal.com",
    business: "rufusp_1337563286_biz@gmail.com"
  },
  test: {
    url: "https://www.sandbox.paypal.com",
    business: "rufusp_1337563286_biz@gmail.com"
  },
  staging: {
    url: "https://www.sandbox.paypal.com",
    business: "rufusp_1337563286_biz@gmail.com"
  },
  production: {
    url: "https://www.paypal.com",
    business: "rufuspost@gmail.com"
  }
}.fetch(Rails.env.to_sym)

