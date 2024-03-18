package com.paymentsdk

import android.util.Log
import com.facebook.react.bridge.*
import com.google.gson.Gson
import com.payment.paymentsdk.PaymentSdkActivity
import com.payment.paymentsdk.PaymentSdkConfigBuilder
import com.payment.paymentsdk.integrationmodels.*
import com.payment.paymentsdk.save_cards.entities.PaymentSDKSavedCardInfo
import com.payment.paymentsdk.sharedclasses.interfaces.CallbackPaymentInterface
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject


class RNPaymentManagerModule(private val reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext), CallbackPaymentInterface {
  private var promise: Promise? = null
  override fun getName(): String {
    return PaymentSDKMODULE
  }

  @ReactMethod
  fun log(message: String?) {
    Log.d(PaymentSDKMODULE, message!!)
  }

  @ReactMethod
  fun startCardPayment(arguments: String, promise: Promise) {
    this.promise = promise
    try {
      val paymentDetails = JSONObject(arguments)
      val configBuilder = createConfiguration(paymentDetails)
      if (!paymentDetails.isNull("theme")) {
        if (paymentDetails.optJSONObject("theme")?.isNull("merchantLogo") == false) {
          val iconUri = paymentDetails.optJSONObject("theme")?.optJSONObject("merchantLogo")?.optString("uri")
          configBuilder.setMerchantIcon(iconUri)
        }
      }
      startPayment(paymentDetails, configBuilder)
    } catch (e: Exception) {
      promise.reject("Error", e.message, Throwable(e.message))
    }
  }

  @ReactMethod
  fun startTokenizedCardPayment(
    arguments: String,
    token: String,
    transactionRef: String,
    promise: Promise,
  ) {
    this.promise = promise
    try {
      val paymentDetails = JSONObject(arguments)
      val configBuilder = createConfiguration(paymentDetails)
      if (!paymentDetails.isNull("theme")) {
        if (paymentDetails.optJSONObject("theme")?.isNull("merchantLogo") == false) {
          val iconUri = paymentDetails.optJSONObject("theme")?.optJSONObject("merchantLogo")?.optString("uri")
          configBuilder.setMerchantIcon(iconUri)
        }
      }
      startTokenizedPayment(paymentDetails, token, transactionRef, configBuilder)
    } catch (e: Exception) {
      promise.reject("Error", e.message, Throwable(e.message))
    }
  }

  @ReactMethod
  fun start3DSecureTokenizedCardPayment(
    arguments: String,
    savedCardInfo: String,
    token: String,
    promise: Promise,
  ) {
    this.promise = promise
    try {
      val paymentDetails = JSONObject(arguments)
      val configBuilder = createConfiguration(paymentDetails)
      val savedCardObject = JSONObject(savedCardInfo)
      val paymentSDKSavedCardInfo = createSavedCardInfo(savedCardObject)
      if (!paymentDetails.isNull("theme")) {
        if (paymentDetails.optJSONObject("theme")?.isNull("merchantLogo") == false) {
          val iconUri = paymentDetails.optJSONObject("theme")?.optJSONObject("merchantLogo")?.optString("uri")
          configBuilder.setMerchantIcon(iconUri)
        }
      }
      start3DsPayment(paymentDetails, paymentSDKSavedCardInfo, token, configBuilder)
    } catch (e: Exception) {
      promise.reject("Error", e.message, Throwable(e.message))
    }
  }

  @ReactMethod
  fun startPaymentWithSavedCards(
    arguments: String,
    support3DS: Boolean,
    promise: Promise,
  ) {
    this.promise = promise
    try {
      val paymentDetails = JSONObject(arguments)
      val configBuilder = createConfiguration(paymentDetails)
      if (!paymentDetails.isNull("theme")) {
        if (paymentDetails.optJSONObject("theme")?.isNull("merchantLogo") == false) {
          val iconUri = paymentDetails.optJSONObject("theme")?.optJSONObject("merchantLogo")?.optString("uri")
          configBuilder.setMerchantIcon(iconUri)
        }
      }
      startSavedCardPayment(paymentDetails, support3DS, configBuilder)
    } catch (e: Exception) {
      promise.reject("Error", e.message, Throwable(e.message))
    }
  }

  private fun startPayment(paymentDetails: JSONObject, configBuilder: PaymentSdkConfigBuilder) {
    val samsungToken = paymentDetails.optString("samsungToken")
    if (samsungToken.isNotEmpty()) PaymentSdkActivity.startSamsungPayment(reactContext.currentActivity!!, configBuilder.build(), samsungToken, this) else PaymentSdkActivity.startCardPayment(reactContext.currentActivity!!, configBuilder.build(), this)
  }

  private fun startTokenizedPayment(
    paymentDetails: JSONObject,
    token: String,
    transactionRef: String,
    configBuilder: PaymentSdkConfigBuilder,
  ) {
    val samsungToken = paymentDetails.optString("samsungToken")
    PaymentSdkActivity.startTokenizedCardPayment(reactContext.currentActivity!!, configBuilder.build(), token, transactionRef, this)
  }

  private fun start3DsPayment(
    paymentDetails: JSONObject,
    savedCardInfo: PaymentSDKSavedCardInfo,
    token: String,
    configBuilder: PaymentSdkConfigBuilder,
  ) {
    val samsungToken = paymentDetails.optString("samsungToken")
    PaymentSdkActivity.start3DSecureTokenizedCardPayment(reactContext.currentActivity!!, configBuilder.build(), savedCardInfo, token, this)
  }

  private fun startSavedCardPayment(
    paymentDetails: JSONObject,
    support3DS: Boolean,
    configBuilder: PaymentSdkConfigBuilder,
  ) {
    val samsungToken = paymentDetails.optString("samsungToken")
    PaymentSdkActivity.startPaymentWithSavedCards(reactContext.currentActivity!!, configBuilder.build(), support3DS, this)
  }

  @ReactMethod
  fun startAlternativePaymentMethod(arguments: String, promise: Promise) {
    this.promise = promise
    try {
      val paymentDetails = JSONObject(arguments)
      val configData = createConfiguration(paymentDetails)
      PaymentSdkActivity.startAlternativePaymentMethods(reactContext.currentActivity!!, configData.build(), this)
    } catch (e: Exception) {
      promise.reject("Error", e.message, Throwable(e.message))
    }
  }

  @ReactMethod
  fun cancelPayment(promise: Promise) {
    this.promise = promise
    try {
      val cancelPayment = PaymentSdkActivity.cancelPayment()
      promise.resolve(cancelPayment)
    } catch (e: Exception) {
      promise.reject("Error", e.message, Throwable(e.message))
    }
  }

  private fun createConfiguration(paymentDetails: JSONObject): PaymentSdkConfigBuilder {
    val profileId = paymentDetails.optString("profileID")
    val serverKey = paymentDetails.optString("serverKey")
    val clientKey = paymentDetails.optString("clientKey")
    val locale = createPaymentSdkLanguageCode(paymentDetails.optString("languageCode"))
    val screenTitle = paymentDetails.optString("screenTitle")
    val orderId = paymentDetails.optString("cartID")
    val cartDesc = paymentDetails.optString("cartDescription")
    val currency = paymentDetails.optString("currency")
    val token = paymentDetails.optString("token")
    val transRef = paymentDetails.optString("transactionReference")
    val amount = paymentDetails.optDouble("amount")
    val timeout = paymentDetails.optLong("expiryTime")
    val tokeniseType = createPaymentSdkTokenise(paymentDetails.optString("tokeniseType"))
    val tokenFormat = createPaymentSdkTokenFormat(paymentDetails.optString("tokenFormat"))
    val transactionType = createPaymentSdkTransactionType(paymentDetails.optString("transactionType"))
    val billingDetails = paymentDetails.optJSONObject("billingDetails")
    var billingData: PaymentSdkBillingDetails? = null
    if (billingDetails != null) {
      billingData = PaymentSdkBillingDetails(billingDetails.optString("city"), billingDetails.optString("countryCode"), billingDetails.optString("email"), billingDetails.optString("name"), billingDetails.optString("phone"), billingDetails.optString("state"), billingDetails.optString("addressLine"), billingDetails.optString("zip"))
    }
    val shippingDetails = paymentDetails.optJSONObject("shippingDetails")
    var shippingData: PaymentSdkShippingDetails? = null
    if (shippingDetails != null) {
      shippingData = PaymentSdkShippingDetails(shippingDetails.optString("city"), shippingDetails.optString("countryCode"), shippingDetails.optString("email"), shippingDetails.optString("name"), shippingDetails.optString("phone"), shippingDetails.optString("state"), shippingDetails.optString("addressLine"), shippingDetails.optString("zip"))
    }
    val apmsJSONArray = paymentDetails.optJSONArray("alternativePaymentMethods")
    val apmsList = mutableListOf<PaymentSdkApms>()
    if (apmsJSONArray != null) {
      apmsList.addAll(createAPMs(apmsJSONArray))
    }
    return PaymentSdkConfigBuilder(profileId, serverKey, clientKey, amount, currency).setCartDescription(cartDesc).setLanguageCode(locale).setBillingData(billingData).setMerchantCountryCode(paymentDetails.optString("merchantCountryCode")).setShippingData(shippingData).setCartId(orderId).setTokenise(tokeniseType, tokenFormat).setTokenisationData(token, transRef).hideCardScanner(paymentDetails.optBoolean("hideCardScanner")).showBillingInfo(paymentDetails.optBoolean("showBillingInfo")).showShippingInfo(paymentDetails.optBoolean("showShippingInfo")).forceShippingInfo(paymentDetails.optBoolean("forceShippingInfo")).setScreenTitle(screenTitle).setAlternativePaymentMethods(apmsList).setTransactionType(transactionType).isDigitalProduct(paymentDetails.optBoolean("isDigitalProduct")).setPaymentExpiry(timeout).enableZeroContacts(paymentDetails.optBoolean("enableZeroContacts"))
      .setCardDiscount(getPaymentSdkCardDiscounts(paymentDetails)).setMetadata(getMetadata())
  }

  private fun getPaymentSdkCardDiscounts(paymentDetails: JSONObject): List<PaymentSdkCardDiscount> {
    val ptCardDiscounts = paymentDetails.optJSONArray("cardDiscounts") ?: return emptyList()
    val paymentSdkCardDiscounts: MutableList<PaymentSdkCardDiscount> = ArrayList()
    for (i in 0 until ptCardDiscounts.length()) {
      val discount = ptCardDiscounts.optJSONObject(i)
      val cardsPrefixes = discount.optJSONArray("discountCards")
      val cards: MutableList<String> = ArrayList()
      if (cardsPrefixes != null) {
        for (j in 0 until cardsPrefixes.length()) {
          cards.add(cardsPrefixes.optString(j))
        }
      }
      val cardDiscount = PaymentSdkCardDiscount(cards,
        discount.optDouble("discountValue"),
        discount.optString("discountTitle"),
        discount.optBoolean("isPercentage"))
      paymentSdkCardDiscounts.add(cardDiscount)
    }
    return paymentSdkCardDiscounts
  }

  private fun getMetadata(): Map<String, Any> {
    val metadata: MutableMap<String, Any> = HashMap()
    metadata["PaymentSDKPluginName"] = "react-native"
    metadata["PaymentSDKPluginVersion"] = "2.6.5"
    return metadata
  }

  private fun createSavedCardInfo(jsonCardInfo: JSONObject): PaymentSDKSavedCardInfo {
    val maskedCard = jsonCardInfo.optString("maskedCard")
    val cardType = jsonCardInfo.optString("cardType")
    return PaymentSDKSavedCardInfo(maskedCard, cardType)
  }

  override fun onError(error: PaymentSdkError) {
    promise!!.reject("Error", error.msg, Throwable(Gson().toJson(error)))
  }

  private fun createAPMs(apmsJSONArray: JSONArray): List<PaymentSdkApms> {
    val apmsList = mutableListOf<PaymentSdkApms>()
    for (i in 0 until apmsJSONArray.length()) {
      val apmString = apmsJSONArray.optString(i)
      val apm = createPaymentSdkApms(apmString)
      apm?.let { apmsList.add(it) }
    }
    return apmsList
  }

  override fun onPaymentFinish(paymentSdkTransactionDetails: PaymentSdkTransactionDetails) {
    if (promise != null) {
      val map = Arguments.createMap()
      val paymentDetails = Gson().toJson(paymentSdkTransactionDetails)
      try {
        val jsonObject = JSONObject(paymentDetails)
        val detailsMap = jsonToReact(jsonObject)
        map.putMap("PaymentDetails", detailsMap)
      } catch (e: JSONException) {
        map.putNull("PaymentDetails")
      }
      promise!!.resolve(map)
    }
  }

  override fun onPaymentCancel() {
    if (promise != null) {
      val map = Arguments.createMap()
      map.putString("Event", "CancelPayment")
      promise!!.resolve(map)
    }
  }

  companion object {
    private const val PaymentSDKMODULE = "RNPaymentManager"
    fun optString(json: JSONObject, key: String?): String {
      return if (json.isNull(key)) "" else json.optString(key, null)
    }

    @Throws(JSONException::class)
    fun jsonToReact(jsonObject: JSONObject): WritableMap {
      val writableMap = Arguments.createMap()
      val iterator: Iterator<*> = jsonObject.keys()
      while (iterator.hasNext()) {
        val key = iterator.next() as String
        val value = jsonObject[key]
        if (value is Float || value is Double) {
          writableMap.putDouble(key, jsonObject.getDouble(key))
        } else if (value is Number) {
          writableMap.putInt(key, jsonObject.getInt(key))
        } else if (value is String) {
          writableMap.putString(key, jsonObject.getString(key))
        } else if (value is JSONObject) {
          writableMap.putMap(key, jsonToReact(jsonObject.getJSONObject(key)))
        } else if (value is JSONArray) {
          writableMap.putArray(key, jsonToReact(jsonObject.getJSONObject(key)) as ReadableArray)
        } else if (value === JSONObject.NULL) {
          writableMap.putNull(key)
        }
      }
      return writableMap
    }
  }
}
