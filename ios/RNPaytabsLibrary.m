#import "RNPaytabsLibrary.h"
#import <React/RCTLog.h>
#import <UIKit/UIKit.h>

@implementation RNPaytabsLibrary

RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

- (NSArray<NSString *> *)supportedEvents
{
    return @[@"EventPreparePaypage"];
}

RCT_EXPORT_METHOD(log:(NSString *)name )
{
    RCTLogInfo(@"Paytabs React Native: %@", name);
}

RCT_EXPORT_METHOD(start:(NSDictionary *)paymentDetails withCallBack:(RCTResponseSenderBlock) callback)
{
    UIViewController *rootViewController = [[[[UIApplication sharedApplication]delegate] window] rootViewController];
    
}

RCT_EXPORT_METHOD(startApplePay:(NSDictionary *)paymentDetails withCallBack:(RCTResponseSenderBlock) callback)
{
    UIViewController *rootViewController = [[[[UIApplication sharedApplication]delegate] window] rootViewController];
    
    
}

@end
