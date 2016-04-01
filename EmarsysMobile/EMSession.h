//
//  EMSession.h
//  EmarsysMobile
//

#import <EmarsysMobile/EMTransaction.h>

#pragma mark - EmarsysMobile Session -

NS_ASSUME_NONNULL_BEGIN

/*!
 * @typedef EMLogLevel
 * @brief A list of log levels.
 * @constant EMLogLevelDebug Print messages with debug or greater severity.
 * @constant EMLogLevelInfo Print messages with info or greater severity.
 * @constant EMLogLevelWarning Print messages with warning or greater severity.
 * @constant EMLogLevelError Print messages only with error severity.
 * @constant EMLogLevelNone Does not print any messages.
 */
typedef NS_ENUM(uint8_t, EMLogLevel) {
    EMLogLevelDebug,
    EMLogLevelInfo,
    EMLogLevelWarning,
    EMLogLevelError,
    EMLogLevelNone = 0xFF
};

/*!
 * @brief The global EmarsysMobile session object.
 */
@interface EMSession : NSObject

- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;

/*!
 * @brief Returns the shared session.
 */
+ (EMSession *)sharedSession;

/*!
 * @brief Send transaction to the recommender server.
 * @param transaction An EMTransaction instance to be send.
 * @warning Please send the transaction only once.
 * @param errorHandler Will be called if an error occurs.
 */
- (void)sendTransaction:(EMTransaction *)transaction
           errorHandler:(void (^)(NSError *error))errorHandler;

/*!
 * @brief Merchant ID.
 */
@property(readwrite, nullable) NSString *merchantID;
/*!
 * @brief Customer email address.
 */
@property(readwrite, nullable) NSString *customerEmail;
/*!
 * @brief Customer ID.
 */
@property(readwrite, nullable) NSString *customerID;
/*!
 * @brief Advertising ID.
 */
@property(readonly, nullable, nonatomic) NSString *advertisingID;
/*!
 * @brief Log level.
 */
@property(readwrite) EMLogLevel logLevel;

@end

NS_ASSUME_NONNULL_END
