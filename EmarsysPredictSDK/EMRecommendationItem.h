//
//  EMRecommendationItem.h
//  EmarsysPredictSDK
//

@import Foundation;

@class EMRecommendationResult;

#pragma mark - Result Item -

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief The result item.
 */
@interface EMRecommendationItem : NSObject

- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;

/*!
 * @brief Item info.
 * @discussion The recommended item record. Keys are fields copied from the
 * product catalog.
 */
@property(readonly) NSDictionary<NSString *, id> *data;

@end

NS_ASSUME_NONNULL_END
