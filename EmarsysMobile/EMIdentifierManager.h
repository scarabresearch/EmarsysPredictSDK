//
//  EMIdentifierManager.h
//  EmarsysMobile
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface EMIdentifierManager : NSObject

- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (EMIdentifierManager *)sharedManager;

@property(nonatomic, readonly) NSString *advertisingIdentifier;

@end

NS_ASSUME_NONNULL_END
