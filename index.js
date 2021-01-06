import { NativeModules } from 'react-native';

const { RNPaytabsLibrary } = NativeModules;

// Parameters
RNPaytabsLibrary.merchant_email = 'pt_merchant_email';
RNPaytabsLibrary.secret_key = 'pt_secret_key';
RNPaytabsLibrary.transaction_title = 'pt_transaction_title';
RNPaytabsLibrary.amount = 'pt_amount';
RNPaytabsLibrary.currency_code = 'pt_currency_code';
RNPaytabsLibrary.customer_email = 'pt_customer_email';
RNPaytabsLibrary.customer_phone_number = 'pt_customer_phone_number';
RNPaytabsLibrary.order_id = 'pt_order_id';
RNPaytabsLibrary.product_name = 'pt_product_name';
RNPaytabsLibrary.timeout_in_seconds = 'pt_timeout_in_seconds';
RNPaytabsLibrary.address_billing = 'pt_address_billing';
RNPaytabsLibrary.city_billing = 'pt_city_billing';
RNPaytabsLibrary.state_billing = 'pt_state_billing';
RNPaytabsLibrary.country_billing = 'pt_country_billing';
RNPaytabsLibrary.postal_code_billing = 'pt_postal_code_billing';
RNPaytabsLibrary.address_shipping = 'pt_address_shipping';
RNPaytabsLibrary.city_shipping = 'pt_city_shipping';
RNPaytabsLibrary.state_shipping = 'pt_state_shipping';
RNPaytabsLibrary.country_shipping = 'pt_country_shipping';
RNPaytabsLibrary.postal_code_shipping = 'pt_postal_code_shipping';
RNPaytabsLibrary.color = 'pt_color';
RNPaytabsLibrary.theme_light = 'pt_theme_light';
RNPaytabsLibrary.language = 'pt_language';
RNPaytabsLibrary.tokenization = 'pt_tokenization';
RNPaytabsLibrary.preauth = 'pt_preauth';
RNPaytabsLibrary.merchant_identifier = 'pt_merchant_identifier';
RNPaytabsLibrary.country_code = 'pt_country_code';
RNPaytabsLibrary.merchant_region = 'pt_merchant_region';
RNPaytabsLibrary.forceShippingInfo = 'pt_force_shipping_info';
export default RNPaytabsLibrary;
