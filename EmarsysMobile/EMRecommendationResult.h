//
//  EMRecommendationResult.h
//  EmarsysMobile
//

@import Foundation;

#import <EmarsysMobile/EMRecommendationItem.h>

#pragma mark - Recommendation Result -

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief The recommendation result.
 * @discussion The recommendation result object contains the recommended items
 * and their product information.
 */
@interface EMRecommendationResult : NSObject

- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;

/*!
 * @brief The array of recommended items.
 * @discussion Each element is an object representing the recommended item with
 * fields copied from the product catalog.
 */
@property(readonly, nonatomic) NSArray<EMRecommendationItem *> *products;
/*!
 * @brief The cohort of the recommendations.
 * @discussion In case of A/B tests this contains the algorithm ID that served
 * the recommendations. Eg. it may contain the string "EMARSYS" if it was served
 * by our algorithm, and "BASELINE" if it's your original algorithm that we are
 * testing against.
 */
@property(readonly) NSString *cohort;
/*!
 * @brief Topic of the recommended items.
 * @discussion A category path.
 */
@property(readonly, nullable) NSString *topic;
/*!
 * @brief The feature ID of the recommendations.
 */
@property(readonly) NSString *featureID;

@end

NS_ASSUME_NONNULL_END
