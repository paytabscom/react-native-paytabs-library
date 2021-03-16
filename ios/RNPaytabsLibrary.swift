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

    @objc(startCardPayment:withResolver:withRejecter:)
    func startCardPayment(paymentDetails: NSDictionary,
                          resolve: RCTPromiseResolveBlock,
                          reject: RCTPromiseRejectBlock) -> Void {
        resolve(paymentDetails)
//        resolve(a*b)
//        PaymentSDK.startCardPayment(on: , configuration: <#T##PaymentSDKConfiguration#>, delegate: <#T##PaymentSDKDelegate?#>)
    }
}
