//
//  RNPaymentManager.swift
//  react-native-paymentsdk
//
//  Created by Mohamed Adly on 16/03/2021.
//

import Foundation
import PaymentSDK
import PassKit


@objc(RNPaymentManager)
class RNPaymentManager: NSObject {
    var resolve: RCTPromiseResolveBlock?
    var reject: RCTPromiseRejectBlock?

    // Track if callback has been invoked to prevent duplicate calls
    private var hasInvokedCallback: Bool = false
    private var lastTransactionReference: String?

    @objc(startCardPayment:withResolver:withRejecter:)
    func startCardPayment(paymentDetails: NSString,
                          resolve: @escaping RCTPromiseResolveBlock,
                          reject: @escaping RCTPromiseRejectBlock) -> Void {
        self.resolve = resolve
        self.reject = reject
        self.hasInvokedCallback = false
        self.lastTransactionReference = nil

        let data = Data((paymentDetails as String).utf8)
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
            let configuration = generateConfiguration(dictionary: dictionary)
            if let rootViewController = getRootController() {
                PaymentManager.startCardPayment(on: rootViewController, configuration: configuration, delegate: self)
            }
        } catch let error {
            reject("Error", error.localizedDescription, error)
        }
    }

     @objc(startTokenizedCardPayment:withToken:withTransactionRef:withResolver:withRejecter:)
    func startTokenizedCardPayment(paymentDetails: NSString,
                                    token: NSString,
                                    transactionRef: NSString,
                          resolve: @escaping RCTPromiseResolveBlock,
                          reject: @escaping RCTPromiseRejectBlock) -> Void {
        self.resolve = resolve
        self.reject = reject
        self.hasInvokedCallback = false
        self.lastTransactionReference = nil

        let data = Data((paymentDetails as String).utf8)
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
            let configuration = generateConfiguration(dictionary: dictionary)
            if let rootViewController = getRootController() {
                PaymentManager.startTokenizedCardPayment(on: rootViewController, configuration: configuration, token: (token as String), transactionRef: (transactionRef as String), delegate: self)
            }
        } catch let error {
            reject("Error", error.localizedDescription, error)
        }
    }

      @objc(startPaymentWithSavedCards:withSupport3DS:withResolver:withRejecter:)
    func startPaymentWithSavedCards(paymentDetails: NSString,
                                    support3DS: Bool,
                          resolve: @escaping RCTPromiseResolveBlock,
                          reject: @escaping RCTPromiseRejectBlock) -> Void {
        self.resolve = resolve
        self.reject = reject
        self.hasInvokedCallback = false
        self.lastTransactionReference = nil

        let data = Data((paymentDetails as String).utf8)
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
            let configuration = generateConfiguration(dictionary: dictionary)
            if let rootViewController = getRootController() {
                // Note: startPaymentWithSavedCards method removed in SDK 6.6.33
                // Using startCardPayment as alternative
                PaymentManager.startCardPayment(on: rootViewController, configuration: configuration, delegate: self)
            }
        } catch let error {
            reject("Error", error.localizedDescription, error)
        }
    }

      @objc(start3DSecureTokenizedCardPayment:withSavedCardInfo:withToken:withResolver:withRejecter:)
    func start3DSecureTokenizedCardPayment(paymentDetails: NSString,
                                    savedCardInfo: NSString,
                                    token: NSString,
                          resolve: @escaping RCTPromiseResolveBlock,
                          reject: @escaping RCTPromiseRejectBlock) -> Void {
        self.resolve = resolve
        self.reject = reject
        self.hasInvokedCallback = false
        self.lastTransactionReference = nil

        let data = Data((paymentDetails as String).utf8)
        let savedCardData = Data((savedCardInfo as String).utf8)
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
            let configuration = generateConfiguration(dictionary: dictionary)
            let savedCardDictionary = try JSONSerialization.jsonObject(with: savedCardData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
            let savedCardInfoObject = generateSavedCardInfo(dictionary: savedCardDictionary)
            if let rootViewController = getRootController(), let _savedCardInfo = savedCardInfoObject {
                PaymentManager.start3DSecureTokenizedCardPayment(on: rootViewController,
                                                                 configuration: configuration,
                                                                 savedCardInfo: _savedCardInfo,
                                                                 token: (token as String),
                                                                 delegate: self)
            }
        } catch let error {
            reject("Error", error.localizedDescription, error)
        }
    }


    @objc(startApplePayPayment:withResolver:withRejecter:)
    func startApplePayPayment(paymentDetails: NSString,
                          resolve: @escaping RCTPromiseResolveBlock,
                          reject: @escaping RCTPromiseRejectBlock) -> Void {
        self.resolve = resolve
        self.reject = reject
        self.hasInvokedCallback = false
        self.lastTransactionReference = nil

        let data = Data((paymentDetails as String).utf8)
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
            let configuration = generateConfiguration(dictionary: dictionary)
            if let rootViewController = getRootController() {
                PaymentManager.startApplePayPayment(on: rootViewController, configuration: configuration, delegate: self)
            }
        } catch let error {
            reject("Error", error.localizedDescription, error)
        }
    }

    @objc(startAlternativePaymentMethod:withResolver:withRejecter:)
    func startAlternativePaymentMethod(paymentDetails: NSString,
                          resolve: @escaping RCTPromiseResolveBlock,
                          reject: @escaping RCTPromiseRejectBlock) -> Void {
        self.resolve = resolve
        self.reject = reject
        self.hasInvokedCallback = false
        self.lastTransactionReference = nil

        let data = Data((paymentDetails as String).utf8)
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
            let configuration = generateConfiguration(dictionary: dictionary)
            if let rootViewController = getRootController() {
                PaymentManager.startAlternativePaymentMethod(on: rootViewController, configuration: configuration, delegate: self)
            }
        } catch let error {
            reject("Error", error.localizedDescription, error)
        }
    }

    @objc(cancelPayment:withRejecter:)
    func cancelPayment(resolve: @escaping RCTPromiseResolveBlock,
                          reject: @escaping RCTPromiseRejectBlock) -> Void {
        self.resolve = resolve
        self.reject = reject

        PaymentManager.cancelPayment { [weak self] (didCancel: Bool?) in
            guard let self = self else { return }
            resolve(["Event": "CancelPayment"])
            self.resolve = nil
        }

    }

    func getRootController() -> UIViewController? {
        if #available(iOS 15.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first(where: { $0.isKeyWindow }) ?? windowScene?.windows.first
            return window?.rootViewController
        } else {
            let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.first
            return keyWindow?.rootViewController
        }
    }

    /// Forwards `paymentApiBaseUrl` only when the native `PaymentSDKConfiguration` implements `setPaymentApiBaseUrl:` (future SDKs). Unknown JSON types are ignored.
    private func applyOptionalPaymentApiBaseUrl(from dictionary: [String: Any], to configuration: PaymentSDKConfiguration) {
        guard let raw = dictionary["paymentApiBaseUrl"] as? String else {
            return
        }
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard let cfg = configuration as? NSObject else { return }
        let sel = NSSelectorFromString("setPaymentApiBaseUrl:")
        guard cfg.responds(to: sel) else { return }
        cfg.perform(sel, with: trimmed)
    }

    private func generateConfiguration(dictionary: [String: Any]) -> PaymentSDKConfiguration {
        let configuration = PaymentSDKConfiguration()
        configuration.profileID = dictionary["profileID"] as? String ?? ""
        configuration.serverKey = dictionary["serverKey"] as? String ?? ""
        configuration.clientKey = dictionary["clientKey"] as? String ?? ""
        configuration.cartID = dictionary["cartID"] as? String ?? ""
        configuration.cartDescription = dictionary["cartDescription"] as? String ?? ""
        configuration.amount = dictionary["amount"] as? Double ?? 0.0
        configuration.currency =  dictionary["currency"] as? String ?? ""
        configuration.merchantName = dictionary["merchantName"] as? String ?? ""
        configuration.screenTitle = dictionary["screenTitle"] as? String
        configuration.merchantCountryCode = dictionary["merchantCountryCode"] as? String ?? ""
        applyOptionalPaymentApiBaseUrl(from: dictionary, to: configuration)
        configuration.merchantIdentifier = dictionary["merchantIdentifier"] as? String
        configuration.simplifyApplePayValidation = dictionary["simplifyApplePayValidation"] as? Bool ?? false
        configuration.languageCode = dictionary["languageCode"] as? String
        configuration.forceShippingInfo = dictionary["forceShippingInfo"] as? Bool ?? false
        configuration.showBillingInfo = dictionary["showBillingInfo"] as? Bool ?? false
        configuration.showShippingInfo = dictionary["showShippingInfo"] as? Bool ?? false
        configuration.token = dictionary["token"] as? String
        configuration.transactionReference = dictionary["transactionReference"] as? String
        configuration.hideCardScanner = dictionary["hideCardScanner"] as? Bool ?? false
        configuration.serverIP = dictionary["serverIP"] as? String
        configuration.isDigitalProduct = dictionary["isDigitalProduct"] as? Bool ?? false
        configuration.enableZeroContacts = dictionary["enableZeroContacts"] as? Bool ?? false
        configuration.expiryTime = dictionary["expiryTime"] as? Int ?? 0

        if let tokeniseType = dictionary["tokeniseType"] as? String,
           let type = mapTokeiseType(tokeniseType: tokeniseType) {
            configuration.tokeniseType = type
        }
        if let tokenFormat = dictionary["tokenFormat"] as? String,
           let type = mapTokenFormat(tokenFormat) {
            configuration.tokenFormat = type
        }

        if let transactionType = dictionary["transactionType"] as? String {
            configuration.transactionType = mapTransactionType(transactionType)
        }

        if let themeDictionary = dictionary["theme"] as? [String: Any],
           let theme = generateTheme(dictionary: themeDictionary) {
            configuration.theme = theme
        } else {
            configuration.theme = .default
        }
        if let billingDictionary = dictionary["billingDetails"] as?  [String: Any] {
            configuration.billingDetails = generateBillingDetails(dictionary: billingDictionary)
        }
        if let shippingDictionary = dictionary["shippingDetails"] as?  [String: Any] {
            configuration.shippingDetails = generateShippingDetails(dictionary: shippingDictionary)
        }
        if let alternativePaymentMethods = dictionary["alternativePaymentMethods"] as? [String] {
            configuration.alternativePaymentMethods = generateAlternativePaymentMethods(apmsArray: alternativePaymentMethods)
        }

        if let discountsDictionary = dictionary["cardDiscounts"] as?  [[String: Any]] {
            configuration.cardDiscounts = generateDiscountDetails(dictionary: discountsDictionary)
        }

      if let paymentNetworksArray = dictionary["paymentNetworks"] as? [String] {
              configuration.paymentNetworks = generatePaymentNetworks(paymentsArray: paymentNetworksArray)
          }
          if let cardApproval = dictionary["cardApproval"] as? [String: Any] {
          configuration.cardApproval = generateCardApproval(dictionary: cardApproval)
          }

        configuration.metaData = ["PaymentSDKPluginName": "react-native", "PaymentSDKPluginVersion": "2.6.9"]

        return configuration
    }

    private func generatePaymentNetworks(paymentsArray: [String]) -> [PKPaymentNetwork] {
        var networks = [PKPaymentNetwork]()
        for paymentNetwork in paymentsArray {
            let network = mapPaymentNetwork(paymentNetwork: paymentNetwork)
            if let network = network {
                networks.append(network)
            }
        }
        return networks
    }

    private func mapPaymentNetwork(paymentNetwork: String) -> PKPaymentNetwork? {
        switch paymentNetwork.lowercased() {
        case "amex":
            return .amex
        case "cartesbancaires":
            return .cartesBancaires
        case "chinaunionpay":
            return .chinaUnionPay
        case "discover":
            return .discover
        case "eftnpos":
            if #available(iOS 12.0, *) {
                return .eftpos
            }
            return nil
        case "electron":
            if #available(iOS 12.0, *) {
                return .electron
            }
            return nil
        case "elo":
            if #available(iOS 12.1.1, *) {
                return .elo
            }
            return nil
        case "idcredit":
            return .idCredit
        case "interac":
            return .interac
        case "jcb":
            return .JCB
        case "mada":
            if #available(iOS 10.3, *) {
                return .mada
            }
            return nil
        case "maestro":
            if #available(iOS 12.0, *) {
                return .maestro
            }
            return nil
        case "mastercard":
            return .masterCard
        case "privateLabel":
            return .privateLabel
        case "quicpay":
            return .quicPay
        case "suica":
            return .suica
        case "visa":
            return .visa
        case "vPay":
            if #available(iOS 12.0, *) {
                return .vPay
            }
            return nil
        case "barcode":
            if #available(iOS 14.0, *) {
                return .barcode
            }
            return nil
        case "girocard":
            if #available(iOS 14.0, *) {
                return .girocard
            }
            return nil
        default:
            return nil
        }
    }

    private func generateSavedCardInfo(dictionary: [String: Any]) -> PaymentSDKSavedCardInfo? {
        guard let maskedCard = dictionary["maskedCard"] as? String,
        let cardType = dictionary["cardType"] as? String else { return nil }

       return PaymentSDKSavedCardInfo(maskedCard: maskedCard, cardType: cardType)
    }


    private func generateBillingDetails(dictionary: [String: Any]) -> PaymentSDKBillingDetails? {
        let billingDetails = PaymentSDKBillingDetails()
        billingDetails.name = dictionary["name"] as? String ?? ""
        billingDetails.phone = dictionary["phone"] as? String ?? ""
        billingDetails.email = dictionary["email"] as? String ?? ""
        billingDetails.addressLine = dictionary["addressLine"] as? String ?? ""
        billingDetails.countryCode = dictionary["countryCode"] as? String ?? ""
        billingDetails.city = dictionary["city"] as? String ?? ""
        billingDetails.state = dictionary["state"] as? String ?? ""
        billingDetails.zip = dictionary["zip"] as? String ?? ""
        return billingDetails
    }
    private func generateShippingDetails(dictionary: [String: Any]) -> PaymentSDKShippingDetails? {
        let shippingDetails = PaymentSDKShippingDetails()
        shippingDetails.name = dictionary["name"] as? String ?? ""
        shippingDetails.phone = dictionary["phone"] as? String ?? ""
        shippingDetails.email = dictionary["email"] as? String ?? ""
        shippingDetails.addressLine = dictionary["addressLine"] as? String ?? ""
        shippingDetails.countryCode = dictionary["countryCode"] as? String ?? ""
        shippingDetails.city = dictionary["city"] as? String ?? ""
        shippingDetails.state = dictionary["state"] as? String ?? ""
        shippingDetails.zip = dictionary["zip"] as? String ?? ""
        return shippingDetails
    }

    private func generateCardApproval(dictionary: [String: Any]) -> PaymentSDKCardApproval? {
       if let validationUrl = dictionary["validationUrl"] as? String,
                let binLength = dictionary["binLength"] as? Int,
                let blockIfNoResponse = dictionary["blockIfNoResponse"] as? Bool {
               return PaymentSDKCardApproval(validationUrl: validationUrl, binLength: binLength, blockIfNoResponse: blockIfNoResponse)
                }
              return nil
    }

       private func generateDiscountDetails(dictionary: [[String: Any]]) -> [PaymentSDKCardDiscount]? {
    var discounts = [PaymentSDKCardDiscount]()

    for dict in dictionary {
        if let discountCard = dict["discountCards"] as? [String],
           let discountValue = dict["discountValue"] as? Double,
           let discountTitle = dict["discountTitle"] as? String,
           let isPercentage = dict["isPercentage"] as? Bool {
            let discount = PaymentSDKCardDiscount(discountCards: discountCard, dicsountValue: discountValue, discountTitle: discountTitle, isPercentage: isPercentage)
            discounts.append(discount)
        }
    }

    return discounts.isEmpty ? nil : discounts
}

    private func generateTheme(dictionary: [String: Any]) -> PaymentSDKTheme? {
     var isDark = false
                var traitCollection: UITraitCollection?
                if #available(iOS 15.0, *) {
                    let scenes = UIApplication.shared.connectedScenes
                    let windowScene = scenes.first as? UIWindowScene
                    traitCollection = windowScene?.windows.first?.traitCollection
                } else {
                    traitCollection = UIApplication.shared.keyWindow?.traitCollection
                }
                
                if let traitCollection = traitCollection {
                    if #available(iOS 12.0, *) {
                        switch traitCollection.userInterfaceStyle {
                        case .light, .unspecified:
                            isDark = false
                        case .dark:
                            isDark = true
                        @unknown default:
                            isDark = false
                        }
                    }
                }

        let theme = PaymentSDKTheme.default
        if let resolvedImage = dictionary["merchantLogo"] {
            theme.logoImage = RCTConvert.uiImage(resolvedImage)
        }
        if let colorHex = dictionary["primaryColor" + "\(isDark ? "Dark" : "")"] as? String {
            theme.primaryColor = UIColor(hex: colorHex)
        }
        if let colorHex = dictionary["primaryFontColor" + "\(isDark ? "Dark" : "")"] as? String {
            theme.primaryFontColor = UIColor(hex: colorHex)
        }
        if let fontName = dictionary["primaryFont"] as? String {
            theme.primaryFont = UIFont.init(name: fontName, size: 16)
        }
        if let colorHex = dictionary["secondaryColor" + "\(isDark ? "Dark" : "")"] as? String {
            theme.secondaryColor = UIColor(hex: colorHex)
        }
        if let colorHex = dictionary["secondaryFontColor" + "\(isDark ? "Dark" : "")"] as? String {
            theme.secondaryFontColor = UIColor(hex: colorHex)
        }
        if let fontName = dictionary["secondaryFont"] as? String {
            theme.secondaryFont = UIFont.init(name: fontName, size: 16)
        }
        if let colorHex = dictionary["strokeColor" + "\(isDark ? "Dark" : "")"] as? String {
            theme.strokeColor = UIColor(hex: colorHex)
        }
        if let value = dictionary["strokeThinckness"] as? CGFloat {
            theme.strokeThinckness = value
        }
        if let value = dictionary["inputsCornerRadius"] as? CGFloat {
            theme.inputsCornerRadius = value
        }
        if let colorHex = dictionary["buttonColor" + "\(isDark ? "Dark" : "")"] as? String {
            theme.buttonColor = UIColor(hex: colorHex)
        }
        if let colorHex = dictionary["buttonFontColor" + "\(isDark ? "Dark" : "")"] as? String {
            theme.buttonFontColor = UIColor(hex: colorHex)
        }
        if let fontName = dictionary["buttonFont"] as? String {
            theme.buttonFont = UIFont.init(name: fontName, size: 16)
        }
        if let colorHex = dictionary["titleFontColor" + "\(isDark ? "Dark" : "")"] as? String {
            theme.titleFontColor = UIColor(hex: colorHex)
        }
        if let fontName = dictionary["titleFont"] as? String {
            theme.titleFont = UIFont.init(name: fontName, size: 16)
        }
        if let colorHex = dictionary["backgroundColor" + "\(isDark ? "Dark" : "")"] as? String {
            theme.backgroundColor = UIColor(hex: colorHex)
        }
        if let colorHex = dictionary["placeholderColor" + "\(isDark ? "Dark" : "")"] as? String {
            theme.placeholderColor = UIColor(hex: colorHex)
        }
        return theme
    }

    private func generateAlternativePaymentMethods(apmsArray: [String]) -> [AlternativePaymentMethod] {
        var apms = [AlternativePaymentMethod]()
        for apmValue in apmsArray {
            if let apm = mapAlternativePaymentMethod(apmValue) {
                apms.append(apm)
            }
        }
        return apms
    }

    /// Map string to TokenFormat without using rawValue (SDK 6.6.42 compatibility).
    private func mapTokenFormat(_ value: String) -> TokenFormat? {
        switch value.lowercased() {
        case "1", "none": return TokenFormat.none
        case "2", "hex32": return .hex32
        case "3", "alphanum20": return .alphaNum20
        case "4", "digit22": return .digit22
        case "5", "digit16": return .digit16
        case "6", "alphanum32": return .alphaNum32
        default: return nil
        }
    }

    /// Map string to TransactionType without using rawValue (SDK 6.6.42 compatibility).
    private func mapTransactionType(_ value: String) -> TransactionType {
        switch value.lowercased() {
        case "auth", "authorize": return .authorize
        case "register": return .register
        case "sale": return .sale
        default: return .sale
        }
    }

    /// Map string to AlternativePaymentMethod without using rawValue (SDK 6.6.42 compatibility).
    private func mapAlternativePaymentMethod(_ value: String) -> AlternativePaymentMethod? {
        switch value.lowercased() {
        case "unionpay", "union_pay": return .unionPay
        case "stcpay", "stc_pay": return .stcPay
        case "valu": return .valu
        case "meezaqr", "meeza_qr": return .meezaQR
        case "omannet", "oman_net": return .omannet
        case "knetcredit", "knet_credit": return .knetCredit
        case "knetdebit", "knet_debit": return .knetDebit
        case "fawry": return .fawry
        case "urpay": return .URPay
        case "aman": return .aman
        case "applepay", "apple_pay": return .applePay
        case "souhoola": return .souhoola
        case "tabby": return .Tabby
        case "tamara": return .tamara
        case "tru": return .tru
        case "forsa": return .forsa
        default: return nil
        }
    }

    /// Map string to TokeniseType by case name (SDK 6.6.42 compatibility).
    private func mapTokeiseType(tokeniseType: String) -> TokeniseType? {
        switch tokeniseType {
        case "userOptionalDefaultOn", "userOptional", "userOptinoal": return .userOptinoal
        case "userMandatory": return .userMandatory
        case "merchantMandatory": return .merchantMandatory
        default: return nil
        }
    }
}

extension RNPaymentManager: PaymentManagerDelegate {
    func paymentManager(didFinishTransaction transactionDetails: PaymentSDKTransactionDetails?, error: Error?) {
        // Prevent duplicate callbacks for the same transaction
        if hasInvokedCallback {
            let currentRef = transactionDetails?.transactionReference
            // If both references are the same (including both being nil), it's a duplicate
            if currentRef == lastTransactionReference {
                print("[PayTabs] Duplicate callback detected. Ignoring.")
                return
            }
        }

        // Mark that we've invoked the callback
        hasInvokedCallback = true
        lastTransactionReference = transactionDetails?.transactionReference

        if let error = error, let reject = reject {
            reject("Error", error.localizedDescription, error)
            self.reject = nil
            return
        }
        if let resolve = resolve {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(transactionDetails)
                let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                resolve(["PaymentDetails": dictionary])
                self.resolve = nil
            } catch  {
                if let reject = reject {
                    reject("Error", error.localizedDescription, error)
                    self.reject = nil
                }
            }
        }
    }

    func paymentManager(didCancelPayment error: Error?) {
        // Prevent duplicate cancel callbacks
        if hasInvokedCallback {
            print("[PayTabs] Duplicate cancel callback detected. Ignoring.")
            return
        }

        hasInvokedCallback = true

        if let resolve = resolve {
            resolve(["Event": "CancelPayment"])
            self.resolve = nil
        }
    }
}
