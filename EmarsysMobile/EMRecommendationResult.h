//
//  EMRecommendationResult.h
//  EmarsysMobile
//

@import Foundation;

#import <EmarsysMobile/EMRecommendationItem.h>

#pragma mark - Recommendation Result -

NS_ASSUME_NONNULL_BEGIN

/// Recommendation result.
@interface EMRecommendationResult : NSObject

- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;

/// The array of recommended items. Each element is an object representing the
/// recommended item with fields copied from the product catalog.
@property(readonly, nonatomic) NSArray<EMRecommendationItem *> *products;
/// In case of A/B tests this contains the algorithm ID that served the
/// recommendations. Eg. it may contain the string "EMARSYS" if it was served by
/// our algorithm, and "BASELINE" if it's your original algorithm that we are
/// testing against.
@property(readonly) NSString *cohort;
/// Topic of the recommended items.
@property(readonly, nullable) NSString *topic;
/// The feature ID of the recommendations.
@property(readonly) NSString *featureID;

@end

NS_ASSUME_NONNULL_END
