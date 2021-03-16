#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNPaytabsLibrary, NSObject)

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

RCT_EXTERN_METHOD(startCardPayment:(NSDictionary *)paymentDetails
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
@end
