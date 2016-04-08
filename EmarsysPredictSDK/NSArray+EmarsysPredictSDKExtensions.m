//
//  NSArray+EmarsysPredictSDKExtensions.m
//  EmarsysPredictSDK
//

#import <CommonCrypto/CommonDigest.h>

#import "NSArray+EmarsysPredictSDKExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSArray (EmarsysPredictSDKExtensions)

- (NSString *)serializeWithSeparator:(NSString *)separator {
    NSMutableString *ret = [[NSMutableString alloc] init];
    const NSUInteger lastIndex = self.count - 1;
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx,
                                       BOOL *_Nonnull stop) {
      [ret appendString:[obj description]];
      if (lastIndex != idx) {
          [ret appendString:separator];
      }
    }];
    return ret;
}

@end

NS_ASSUME_NONNULL_END
