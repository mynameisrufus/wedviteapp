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

# success = {
#  "mc_gross"=>"79.90",
#  "protection_eligibility"=>"Ineligible",
#  "item_number1"=>"",
#  "item_number2"=>"",
#  "payer_id"=>"E2Y8P6JQF2WKL",
#  "tax"=>"0.00",
#  "payment_date"=>"21:43:30 Jun 17, 2012 PDT",
#  "payment_status"=>"Completed",
#  "charset"=>"windows-1252",
#  "mc_shipping"=>"0.00",
#  "mc_handling"=>"0.00",
#  "first_name"=>"Rufus",
#  "mc_fee"=>"3.02",
#  "notify_version"=>"3.4",
#  "custom"=>"",
#  "payer_status"=>"verified",
#  "business"=>"rufusp_1337563286_biz@gmail.com",
#  "num_cart_items"=>"2",
#  "mc_handling1"=>"0.00",
#  "mc_handling2"=>"0.00",
#  "payer_email"=>"rufusp_1337563233_per@gmail.com",
#  "verify_sign"=>"Au1-ULy2TUriM5IYrE7p173qvLhVAg1ILqBq2455CSaq2CfnEwrR1YX0",
#  "mc_shipping1"=>"0.00",
#  "mc_shipping2"=>"0.00",
#  "tax1"=>"0.00",
#  "tax2"=>"0.00",
#  "txn_id"=>"1M298731UG0277217",
#  "payment_type"=>"instant",
#  "last_name"=>"Post",
#  "item_name1"=>"Plan Payment",
#  "receiver_email"=>"rufusp_1337563286_biz@gmail.com",
#  "item_name2"=>"Stationery",
#  "payment_fee"=>"3.02",
#  "quantity1"=>"1",
#  "quantity2"=>"1",
#  "receiver_id"=>"XY6RBJSDPVAUS",
#  "txn_type"=>"cart",
#  "mc_gross_1"=>"49.95",
#  "mc_currency"=>"USD",
#  "mc_gross_2"=>"29.95",
#  "residence_country"=>"US",
#  "test_ipn"=>"1",
#  "transaction_subject"=>"Shopping CartPlan PaymentStationery",
#  "payment_gross"=>"79.90",
#  "wedding_id"=>"1"
#}

PAYPAL = unless Rails.env.production? 
  {
    url: "https://www.sandbox.paypal.com/cgi-bin/webscr",
    business: "rufusp_1337563286_biz@gmail.com"
  }
else
  {
    url: "https://www.paypal.com/cgi-bin/webscr",
    business: "rufuspost@gmail.com"
  }
end
