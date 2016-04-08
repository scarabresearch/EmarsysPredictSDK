//
//  NSString+EmarsysPredictSDKExtensions.m
//  EmarsysPredictSDK
//

#import <CommonCrypto/CommonDigest.h>

#import "NSString+EmarsysPredictSDKExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSString (EmarsysPredictSDKExtensions)

- (NSString *)sha1 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *ret =
        [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x", digest[i]];
    }
    return ret;
}

@end

NS_ASSUME_NONNULL_END
