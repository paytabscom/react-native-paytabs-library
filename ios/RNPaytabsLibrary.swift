//
//  RNPaytabsLibrary.swift
//  react-native-paytabs-emulator
//
//  Created by Mohamed Adly on 16/03/2021.
//

import Foundation
import PaymentSDK

@objc(RNPaytabsLibrary)
class RNPaytabsLibrary: NSObject {
    var resolve: RCTPromiseResolveBlock?
    var reject: RCTPromiseRejectBlock?
    
    @objc(startCardPayment:withResolver:withRejecter:)
    func startCardPayment(paymentDetails: NSString,
                          resolve: @escaping RCTPromiseResolveBlock,
                          reject: @escaping RCTPromiseRejectBlock) -> Void {
        self.resolve = resolve
        self.reject = reject
        let data = Data((paymentDetails as String).utf8)
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
            let configuration = generateConfiguration(dictionary: dictionary)
            if let rootViewController = getRootController() {
                PaymentSDK.startCardPayment(on: rootViewController, configuration: configuration, delegate: self)
            }
        } catch let error {
            reject("", error.localizedDescription, error)
        }
    }
    
    @objc(startApplePayPayment:withResolver:withRejecter:)
    func startApplePayPayment(paymentDetails: NSString,
                          resolve: @escaping RCTPromiseResolveBlock,
                          reject: @escaping RCTPromiseRejectBlock) -> Void {
        self.resolve = resolve
        self.reject = reject
        let data = Data((paymentDetails as String).utf8)
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
            let configuration = generateConfiguration(dictionary: dictionary)
            if let rootViewController = getRootController() {
                PaymentSDK.startApplePayPayment(on: rootViewController, configuration: configuration, delegate: self)
            }
        } catch let error {
            reject("", error.localizedDescription, error)
        }
    }
    
    func getRootController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.first
            let topController = keyWindow?.rootViewController
            return topController
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
        if let tokeniseType = dictionary["tokeniseType"] as? Int,
           let type = TokeniseType.getType(type: tokeniseType) {
            configuration.tokeniseType = type
        }
        if let tokenFormat = dictionary["tokenFormat"] as? String,
           let type = TokenFormat.getType(type: tokenFormat) {
            configuration.tokenFormat = type
        }
        
//        public var paymentNetworks: [PKPaymentNetwork]?

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
        return configuration
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
    
    private func generateTheme(dictionary: [String: Any]) -> PaymentSDKTheme? {
        let theme = PaymentSDKTheme.default
        if let imageName = dictionary["logoImage"] as? String {
            theme.logoImage = UIImage(named: imageName)
        }
        if let colorHex = dictionary["primaryColor"] as? String {
            theme.primaryColor = UIColor(hex: colorHex)
        }
        if let colorHex = dictionary["primaryFontColor"] as? String {
            theme.primaryFontColor = UIColor(hex: colorHex)
        }
        if let fontName = dictionary["primaryFont"] as? String {
            theme.primaryFont = UIFont.init(name: fontName, size: 16)
        }
        if let colorHex = dictionary["secondaryColor"] as? String {
            theme.secondaryColor = UIColor(hex: colorHex)
        }
        if let colorHex = dictionary["secondaryFontColor"] as? String {
            theme.secondaryFontColor = UIColor(hex: colorHex)
        }
        if let fontName = dictionary["secondaryFont"] as? String {
            theme.secondaryFont = UIFont.init(name: fontName, size: 16)
        }
        if let colorHex = dictionary["strokeColor"] as? String {
            theme.strokeColor = UIColor(hex: colorHex)
        }
        if let value = dictionary["strokeThinckness"] as? CGFloat {
            theme.strokeThinckness = value
        }
        if let value = dictionary["inputsCornerRadius"] as? CGFloat {
            theme.inputsCornerRadius = value
        }
        if let colorHex = dictionary["buttonColor"] as? String {
            theme.buttonColor = UIColor(hex: colorHex)
        }
        if let colorHex = dictionary["buttonFontColor"] as? String {
            theme.buttonFontColor = UIColor(hex: colorHex)
        }
        if let fontName = dictionary["buttonFont"] as? String {
            theme.buttonFont = UIFont.init(name: fontName, size: 16)
        }
        if let colorHex = dictionary["titleFontColor"] as? String {
            theme.titleFontColor = UIColor(hex: colorHex)
        }
        if let fontName = dictionary["titleFont"] as? String {
            theme.titleFont = UIFont.init(name: fontName, size: 16)
        }
        if let colorHex = dictionary["backgroundColor"] as? String {
            theme.backgroundColor = UIColor(hex: colorHex)
        }
        if let colorHex = dictionary["placeholderColor"] as? String {
            theme.placeholderColor = UIColor(hex: colorHex)
        }
        return theme
    }
    
}

extension RNPaytabsLibrary: PaymentSDKDelegate {
    func paymentSDK(didFinishTransaction transactionDetails: PaymentSDKTransactionDetails?, error: Error?) {
        if let error = error, let reject = reject {
            return reject("", error.localizedDescription, error)
        }
        if let resolve = resolve {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(transactionDetails)
                let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                resolve(dictionary)
            } catch  {
                if let reject = reject {
                    reject("", error.localizedDescription, error)
                }
            }
        }
    }
}
