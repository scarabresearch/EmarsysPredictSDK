//
//  EMIdentifierManager.h
//  EmarsysPredictSDK
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface EMIdentifierManager : NSObject

- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (EMIdentifierManager *)sharedManager;

- (nullable NSString *)advertisingIdentifier;
- (void)setAdvertisingIdentifier:(NSString *)advertisingIdentifier;

@end

NS_ASSUME_NONNULL_END
