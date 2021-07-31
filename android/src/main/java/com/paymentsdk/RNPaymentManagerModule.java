package com.paymentsdk;

import static com.payment.paymentsdk.integrationmodels.PaymentSdkApmsKt.createPaymentSdkApms;
import static com.payment.paymentsdk.integrationmodels.PaymentSdkLanguageCodeKt.createPaymentSdkLanguageCode;
import static com.payment.paymentsdk.integrationmodels.PaymentSdkTokenFormatKt.createPaymentSdkTokenFormat;
import static com.payment.paymentsdk.integrationmodels.PaymentSdkTokeniseKt.createPaymentSdkTokenise;
import static com.payment.paymentsdk.integrationmodels.PaymentSdkTransactionTypeKt.createPaymentSdkTransactionType;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.os.AsyncTask;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.WritableMap;
import com.google.gson.Gson;
import com.payment.paymentsdk.PaymentSdkActivity;
import com.payment.paymentsdk.PaymentSdkConfigBuilder;
import com.payment.paymentsdk.integrationmodels.PaymentSdkApms;
import com.payment.paymentsdk.integrationmodels.PaymentSdkBillingDetails;
import com.payment.paymentsdk.integrationmodels.PaymentSdkError;
import com.payment.paymentsdk.integrationmodels.PaymentSdkLanguageCode;
import com.payment.paymentsdk.integrationmodels.PaymentSdkShippingDetails;
import com.payment.paymentsdk.integrationmodels.PaymentSdkTokenFormat;
import com.payment.paymentsdk.integrationmodels.PaymentSdkTokenise;
import com.payment.paymentsdk.integrationmodels.PaymentSdkTransactionDetails;
import com.payment.paymentsdk.integrationmodels.PaymentSdkTransactionType;
import com.payment.paymentsdk.sharedclasses.interfaces.CallbackPaymentInterface;

import org.jetbrains.annotations.NotNull;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;

public class RNPaymentManagerModule extends ReactContextBaseJavaModule implements CallbackPaymentInterface {

    private final ReactApplicationContext reactContext;
    private static String PaymentSDK_MODULE = "RNPaymentManager";
    private Promise promise;

    public RNPaymentManagerModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return PaymentSDK_MODULE;
    }

    @ReactMethod
        public void log(String message) {
        Log.d(PaymentSDK_MODULE, message);
    }

    @ReactMethod
    public void startCardPayment(final String arguments,final Promise promise) {
        this.promise = promise;
        try {
            final JSONObject paymentDetails = new JSONObject(arguments);
            String logoUri = paymentDetails.optJSONObject("theme").optJSONObject("merchantLogo").optString("uri");
            final PaymentSdkConfigBuilder configBuilder = createConfiguration(paymentDetails);
            configBuilder.setMerchantIcon(logoUri);
            startPayment(paymentDetails, configBuilder);

        } catch (Exception e) {
            promise.reject("Error", e.getMessage(), new Throwable(e.getMessage()));
        }
    }

    private void startPayment(JSONObject paymentDetails, PaymentSdkConfigBuilder configBuilder) {
        String samsungToken = paymentDetails.optString("samsungToken");
        if (samsungToken != null && samsungToken.length() > 0)
            PaymentSdkActivity.startSamsungPayment(reactContext.getCurrentActivity(), configBuilder.build(), samsungToken, this);
        else
            PaymentSdkActivity.startCardPayment(reactContext.getCurrentActivity(), configBuilder.build(), this);
    }

    @ReactMethod
    public void startAlternativePaymentMethod(final String arguments, final Promise promise) {
        this.promise = promise;
        try {
            JSONObject paymentDetails = new JSONObject(arguments);
            PaymentSdkConfigBuilder configData = createConfiguration(paymentDetails);
            PaymentSdkActivity.startAlternativePaymentMethods(reactContext.getCurrentActivity(), configData.build(), this);
        } catch (Exception e) {
            promise.reject("Error", e.getMessage(), new Throwable(e.getMessage()));
        }
    }

    private PaymentSdkConfigBuilder createConfiguration(JSONObject paymentDetails) {
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
        PaymentSdkTransactionType transactionType = createPaymentSdkTransactionType(paymentDetails.optString("transactionType"));

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
        JSONArray apmsJSONArray = paymentDetails.optJSONArray("alternativePaymentMethods");
        ArrayList<PaymentSdkApms> apmsList = new ArrayList<PaymentSdkApms>();
        if (apmsJSONArray != null) {
            apmsList =  createAPMs(apmsJSONArray);
        }
        PaymentSdkConfigBuilder configData = new PaymentSdkConfigBuilder(
                profileId, serverKey, clientKey, amount, currency)
                .setCartDescription(cartDesc)
                .setLanguageCode(locale)
                .setBillingData(billingData)
                .setMerchantCountryCode(paymentDetails.optString("merchantCountryCode"))
                .setShippingData(shippingData)
                .setCartId(orderId)
                .setTokenise(tokeniseType, tokenFormat)
                .setTokenisationData(token, transRef)
                .hideCardScanner(paymentDetails.optBoolean("hideCardScanner"))
                .showBillingInfo(paymentDetails.optBoolean("showBillingInfo"))
                .showShippingInfo(paymentDetails.optBoolean("showShippingInfo"))
                .forceShippingInfo(paymentDetails.optBoolean("forceShippingInfo"))
                .setScreenTitle(screenTitle)
                .setAlternativePaymentMethods(apmsList)
                .setTransactionType(transactionType);

        return configData;
    }

    private void getDrawableFromUri(final String path, final RetrieveDrawableListener listener) {
        try {
            new AsyncTask<String, Integer, BitmapDrawable>() {

                @Override
                protected BitmapDrawable doInBackground(String... strings) {
                    Bitmap bmp = null;
                    try {
                        HttpURLConnection connection = (HttpURLConnection) new URL(path).openConnection();
                        connection.connect();
                        InputStream input = connection.getInputStream();
                        bmp = BitmapFactory.decodeStream(input);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    Resources resources = reactContext.getResources();
                    return new BitmapDrawable(resources, bmp);
                }

                protected void onPostExecute(BitmapDrawable result) {

                    //Add image to ImageView
                    listener.getDrawable(result);

                }


            }.execute();
        } catch (Exception e) {
            log(e.getLocalizedMessage());
        }
    }


    @Override
    public void onError(@NotNull PaymentSdkError err) {
        promise.reject("Error",err.getMsg(), new Throwable(new Gson().toJson(err)));
    }

    private ArrayList<PaymentSdkApms> createAPMs(JSONArray apmsJSONArray) {
        ArrayList<PaymentSdkApms> apmsList = new ArrayList<PaymentSdkApms>();
        for (int i = 0; i < apmsJSONArray.length(); i++) {
            String apmString = apmsJSONArray.optString(i);
            PaymentSdkApms apm = createPaymentSdkApms(apmString);
            apmsList.add(apm);
        }
        return apmsList;
    }

    @Override
    public void onPaymentFinish(@NotNull PaymentSdkTransactionDetails paymentSdkTransactionDetails) {
        if (promise != null) {
            WritableMap map = Arguments.createMap();
            String paymentDetails = new Gson().toJson(paymentSdkTransactionDetails);
            try {
                JSONObject jsonObject = new JSONObject(paymentDetails);
                WritableMap detailsMap = jsonToReact(jsonObject);
                map.putMap("PaymentDetails", detailsMap);
            } catch (JSONException e) {
                map.putNull("PaymentDetails");
            }
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

    public static WritableMap jsonToReact(JSONObject jsonObject) throws JSONException {
        WritableMap writableMap = Arguments.createMap();
        Iterator iterator = jsonObject.keys();
        while(iterator.hasNext()) {
            String key = (String) iterator.next();
            Object value = jsonObject.get(key);
            if (value instanceof Float || value instanceof Double) {
                writableMap.putDouble(key, jsonObject.getDouble(key));
            } else if (value instanceof Number) {
                writableMap.putInt(key, jsonObject.getInt(key));
            } else if (value instanceof String) {
                writableMap.putString(key, jsonObject.getString(key));
            } else if (value instanceof JSONObject) {
                writableMap.putMap(key,jsonToReact(jsonObject.getJSONObject(key)));
            } else if (value instanceof JSONArray){
                writableMap.putArray(key, (ReadableArray) jsonToReact(jsonObject.getJSONObject(key)));
            } else if (value == JSONObject.NULL){
                writableMap.putNull(key);
            }
        }
        return writableMap;
    }
}