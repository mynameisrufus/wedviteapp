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
#   "mc_gross"=>"49.95",
#   "protection_eligibility"=>"Ineligible",
#   "payer_id"=>"E2Y8P6JQF2WKL",
#   "tax"=>"0.00", "payment_date"=>"19:34:28 May 20, 2012 PDT",
#   "payment_status"=>"Completed",
#   "charset"=>"windows-1252",
#   "first_name"=>"Rufus",
#   "mc_fee"=>"2.00",
#   "notify_version"=>"3.4",
#   "custom"=>"",
#   "payer_status"=>"verified",
#   "business"=>"rufusp_1337563286_biz@gmail.com",
#   "quantity"=>"1",
#   "payer_email"=>"rufusp_1337563233_per@gmail.com",
#   "verify_sign"=>"Ap83EoSxw7IKa2mt6Pi.OqT.h2q6AyHDsqMO4fHpleKY7cTxRlUulE9F",
#   "txn_id"=>"5PX36982R4563640F",
#   "payment_type"=>"instant",
#   "last_name"=>"Post",
#   "receiver_email"=>"rufusp_1337563286_biz@gmail.com",
#   "payment_fee"=>"2.00",
#   "receiver_id"=>"XY6RBJSDPVAUS",
#   "txn_type"=>"web_accept",
#   "item_name"=>"Wedvite Wedding Payment",
#   "mc_currency"=>"USD",
#   "item_number"=>"",
#   "residence_country"=>"US",
#   "test_ipn"=>"1",
#   "handling_amount"=>"0.00",
#   "transaction_subject"=>"Wedvite Wedding Payment",
#   "payment_gross"=>"49.95",
#   "shipping"=>"0.00",
#   "wedding_id"=>"2"
# }

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
