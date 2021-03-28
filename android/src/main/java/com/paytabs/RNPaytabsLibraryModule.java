package com.paytabs;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import static com.payment.paymentsdk.integrationmodels.PaymentSdkLanguageCodeKt.createPaymentSdkLanguageCode;
import static com.payment.paymentsdk.integrationmodels.PaymentSdkTokenFormatKt.createPaymentSdkTokenFormat;
import static com.payment.paymentsdk.integrationmodels.PaymentSdkTokeniseKt.createPaymentSdkTokenise;

import com.facebook.react.bridge.WritableMap;
import com.google.gson.Gson;
import com.payment.paymentsdk.PaymentSdkActivity;
import com.payment.paymentsdk.PaymentSdkConfigBuilder;
import com.payment.paymentsdk.integrationmodels.PaymentSdkBillingDetails;
import com.payment.paymentsdk.integrationmodels.PaymentSdkConfigurationDetails;
import com.payment.paymentsdk.integrationmodels.PaymentSdkError;
import com.payment.paymentsdk.integrationmodels.PaymentSdkLanguageCode;
import com.payment.paymentsdk.integrationmodels.PaymentSdkShippingDetails;
import com.payment.paymentsdk.integrationmodels.PaymentSdkTokenFormat;
import com.payment.paymentsdk.integrationmodels.PaymentSdkTokenise;
import com.payment.paymentsdk.integrationmodels.PaymentSdkTransactionDetails;
import com.payment.paymentsdk.sharedclasses.interfaces.CallbackPaymentInterface;

import org.jetbrains.annotations.NotNull;
import org.json.JSONObject;

import com.facebook.react.bridge.Promise;

import java.util.HashMap;
import java.util.Map;

public class RNPaytabsLibraryModule extends ReactContextBaseJavaModule implements CallbackPaymentInterface {

    private final ReactApplicationContext reactContext;
    private static String PAYTABS_MODULE = "RNPaytabsLibrary";
    private Promise promise;

    public RNPaytabsLibraryModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
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
    public void startCardPayment(final String arguments,final Promise promise) {
        this.promise = promise;
        try {
            JSONObject paymentDetails = new JSONObject(arguments);
            String profileId = paymentDetails.optString("profileID");
            String serverKey = paymentDetails.optString("serverKey");
            String clientKey = paymentDetails.optString("clientKey");
            PaymentSdkLanguageCode locale = createPaymentSdkLanguageCode(paymentDetails.optString("languageCode"));
            String screenTitle = paymentDetails.optString("screenTitle");
            String orderId = paymentDetails.optString("cartID");
            String cartDesc = paymentDetails.optString("cartDescription");
            String currency = paymentDetails.optString("currency");
            String token = paymentDetails.optString("token");
            String transRef = paymentDetails.optString("transactionReference");
            double amount = paymentDetails.optDouble("amount");

            PaymentSdkTokenise tokeniseType = createPaymentSdkTokenise(paymentDetails.optString("tokeniseType"));
            PaymentSdkTokenFormat tokenFormat = createPaymentSdkTokenFormat(paymentDetails.optString("tokenFormat"));

            JSONObject billingDetails = paymentDetails.optJSONObject("billingDetails");
            PaymentSdkBillingDetails billingData = null;
            if(billingDetails != null) {
                billingData = new PaymentSdkBillingDetails(
                        billingDetails.optString("city"),
                        billingDetails.optString("countryCode"),
                        billingDetails.optString("email"),
                        billingDetails.optString("name"),
                        billingDetails.optString("phone"), billingDetails.optString("state"),
                        billingDetails.optString("addressLine"), billingDetails.optString("zip")
                );
            }
            JSONObject shippingDetails = paymentDetails.optJSONObject("shippingDetails");
            PaymentSdkShippingDetails shippingData = null;
            if(shippingDetails != null ) {
                shippingData = new PaymentSdkShippingDetails(
                        shippingDetails.optString("city"),
                        shippingDetails.optString("countryCode"),
                        shippingDetails.optString("email"),
                        shippingDetails.optString("name"),
                        shippingDetails.optString("phone"), shippingDetails.optString("state"),
                        shippingDetails.optString("addressLine"), shippingDetails.optString("zip")
                );
            }
            PaymentSdkConfigurationDetails configData = new PaymentSdkConfigBuilder(
                    profileId, serverKey, clientKey, amount, currency)
                    .setCartDescription(cartDesc)
                    .setLanguageCode(locale)
                    .setBillingData(billingData)
                    .setMerchantCountryCode(paymentDetails.optString("merchantCountryCode"))
                    .setShippingData(shippingData)
                    .setCartId(orderId)
                    .setTokenise(tokeniseType, tokenFormat)
                    .setTokenisationData(token, transRef)
                    .showBillingInfo(paymentDetails.optBoolean("showBillingInfo"))
                    .showShippingInfo(paymentDetails.optBoolean("showShippingInfo"))
                    .forceShippingInfo(paymentDetails.optBoolean("forceShippingInfo"))
                    .setScreenTitle(screenTitle)
                    .build();
            String samsungToken = paymentDetails.optString("samsungToken");
            if (samsungToken != null && samsungToken.length() > 0)
                PaymentSdkActivity.startSamsungPayment(reactContext.getCurrentActivity(), configData, samsungToken, this);
            else
                PaymentSdkActivity.startCardPayment(reactContext.getCurrentActivity(), configData, this);
        } catch (Exception e) {
            promise.reject("Error",e.getMessage(), new Throwable(e.getMessage()));
        }
    }

    @Override
    public void onError(@NotNull PaymentSdkError err) {
        promise.reject("Error",err.getMsg(), new Throwable(new Gson().toJson(err)));
    }

    @Override
    public void onPaymentFinish(@NotNull PaymentSdkTransactionDetails paymentSdkTransactionDetails) {
        if (promise != null) {
            WritableMap map = Arguments.createMap();
            String details = new Gson().toJson(paymentSdkTransactionDetails);
            map.putString("PaymentDetails", details);
            promise.resolve(map);
        }
    }

    @Override
    public void onPaymentCancel() {
        if (promise != null) {
            WritableMap map = Arguments.createMap();
            map.putString("Event", "CancelPayment");
            promise.resolve(map);
        }
    }
}