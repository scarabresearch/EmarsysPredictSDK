//
//  EMSession.h
//  EmarsysMobile
//

#import <EmarsysMobile/EMTransaction.h>

#pragma mark - EmarsysMobile Session -

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(uint8_t, EMLogLevel) {
    EMLogLevelDebug,
    EMLogLevelInfo,
    EMLogLevelWarning,
    EMLogLevelError,
    EMLogLevelNone
};

/// The global EmarsysMobile session object.
@interface EMSession : NSObject

- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;

/// Returns the shared session.
+ (EMSession *)sharedSession;

/// Send transaction to the recommender server.
- (void)sendTransaction:(EMTransaction *)transaction
           errorHandler:(void (^)(NSError *error))errorHandler;

/// Merchant ID.
@property(readwrite, nullable) NSString *merchantID;
/// Customer email address.
@property(readwrite, nullable) NSString *customerEmail;
/// Customer ID.
@property(readwrite, nullable) NSString *customerID;
/// Advertising ID.
@property(readonly, nonnull, nonatomic) NSString *advertisingID;
/// Log level.
@property(readwrite) EMLogLevel logLevel;

@end

NS_ASSUME_NONNULL_END
