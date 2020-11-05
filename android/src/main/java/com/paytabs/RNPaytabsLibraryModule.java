package com.paytabs;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.paytabs.paytabs_sdk.payment.ui.activities.PayTabActivity;
import com.paytabs.paytabs_sdk.utils.PaymentParams;

import static android.app.Activity.RESULT_OK;

public class RNPaytabsLibraryModule extends ReactContextBaseJavaModule implements ActivityEventListener {

    private final ReactApplicationContext reactContext;
    private static int PAYMENT_REQUEST_CODE = 4040;
    private static String PAYTABS_MODULE = "RNPaytabsLibrary";
    private Callback mCallback;

    public RNPaytabsLibraryModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        this.reactContext.addActivityEventListener(this);
    }

    @Override
    public String getName() {
        return PAYTABS_MODULE;
    }

    @ReactMethod
    public void log(String message) {
        Log.d(PAYTABS_MODULE, message);
    }

    @ReactMethod
    public void start(ReadableMap paymentDetails, final Callback callback) {
        this.mCallback = callback;

        Intent in = new Intent(reactContext, PayTabActivity.class);
        in.putExtra(PaymentParams.MERCHANT_EMAIL, paymentDetails.getString("pt_merchant_email")); //this a demo account for testing the sdk
        in.putExtra(PaymentParams.SECRET_KEY,paymentDetails.getString("pt_secret_key"));//Add your Secret Key Here
        in.putExtra(PaymentParams.LANGUAGE,paymentDetails.getString("pt_language"));
        in.putExtra(PaymentParams.TRANSACTION_TITLE, paymentDetails.getString("pt_transaction_title"));
        in.putExtra(PaymentParams.AMOUNT, Double.parseDouble(paymentDetails.getString("pt_amount")));

        in.putExtra(PaymentParams.CURRENCY_CODE, paymentDetails.getString("pt_currency_code"));
        in.putExtra(PaymentParams.CUSTOMER_PHONE_NUMBER, paymentDetails.getString("pt_customer_phone_number"));
        in.putExtra(PaymentParams.CUSTOMER_EMAIL, paymentDetails.getString("pt_customer_email"));
        in.putExtra(PaymentParams.ORDER_ID, paymentDetails.getString("pt_order_id"));
        in.putExtra(PaymentParams.PRODUCT_NAME, paymentDetails.getString("pt_product_name"));

        //Billing Address
        in.putExtra(PaymentParams.ADDRESS_BILLING, paymentDetails.getString("pt_address_billing"));
        in.putExtra(PaymentParams.CITY_BILLING, paymentDetails.getString("pt_city_billing"));
        in.putExtra(PaymentParams.STATE_BILLING, paymentDetails.getString("pt_state_billing"));
        in.putExtra(PaymentParams.COUNTRY_BILLING, paymentDetails.getString("pt_country_billing"));
        in.putExtra(PaymentParams.POSTAL_CODE_BILLING, paymentDetails.getString("pt_postal_code_billing")); //Put Country Phone code if Postal code not available '00973'

        //Shipping Address
        in.putExtra(PaymentParams.ADDRESS_SHIPPING, paymentDetails.getString("pt_address_shipping"));
        in.putExtra(PaymentParams.CITY_SHIPPING, paymentDetails.getString("pt_city_shipping"));
        in.putExtra(PaymentParams.STATE_SHIPPING, paymentDetails.getString("pt_state_shipping"));
        in.putExtra(PaymentParams.COUNTRY_SHIPPING, paymentDetails.getString("pt_country_shipping"));
        in.putExtra(PaymentParams.POSTAL_CODE_SHIPPING, paymentDetails.getString("pt_postal_code_shipping")); //Put Country Phone code if Postal code not available '00973'

        //Payment Page Style
        in.putExtra(PaymentParams.PAY_BUTTON_COLOR, paymentDetails.getString("pt_color"));

        //Tokenization
        in.putExtra(PaymentParams.IS_TOKENIZATION, paymentDetails.getBoolean("pt_tokenization"));
        
        //Pre auth
        in.putExtra(PaymentParams.IS_PREAUTH, paymentDetails.getBoolean("pt_preauth"));

        //Merchant region
        String merchant_region =  paymentDetails.getString("pt_merchant_region");
        in.putExtra(PaymentParams.REGION_ENDPOINT, merchant_region);

        reactContext.startActivityForResult(in, PaymentParams.PAYMENT_REQUEST_CODE, new Bundle());
    }

    @Override
    public void onActivityResult(Activity activity,int requestCode, int resultCode, Intent data) {

        WritableMap map = Arguments.createMap();
        if (resultCode == RESULT_OK && requestCode == PaymentParams.PAYMENT_REQUEST_CODE) {
            map.putString("pt_response_code", data.getStringExtra(PaymentParams.RESPONSE_CODE));
            map.putString("pt_transaction_id", data.getStringExtra(PaymentParams.TRANSACTION_ID));
            map.putString("pt_result", data.getStringExtra(PaymentParams.RESULT_MESSAGE));
            if (data.hasExtra(PaymentParams.TOKEN) && !data.getStringExtra(PaymentParams.TOKEN).isEmpty()) {
                map.putString("pt_token", data.getStringExtra(PaymentParams.TOKEN));
                map.putString("pt_token_customer_password", data.getStringExtra(PaymentParams.CUSTOMER_PASSWORD));
                map.putString("pt_token_customer_email", data.getStringExtra(PaymentParams.CUSTOMER_EMAIL));
            }
        }
        
        if (mCallback != null)
          mCallback.invoke(map);
    }
    @Override
    public void onNewIntent(Intent intent) {

    }
}