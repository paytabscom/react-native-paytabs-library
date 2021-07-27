#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNPaymentManager, NSObject)

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

RCT_EXTERN_METHOD(startCardPayment:(NSString *)paymentDetails
                  withResolver:(RCTPromiseResolveBlock)resolve                  
                  withRejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(startApplePayPayment:(NSString *)paymentDetails
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(startAlternativePaymentMethod:(NSString *)paymentDetails
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)

@end
