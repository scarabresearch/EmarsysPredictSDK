//
//  EMRecommendationRequest.h
//  EmarsysMobile
//

@import Foundation;

#import <EmarsysMobile/EMRecommendationResult.h>

#pragma mark - Recommendation Request -

NS_ASSUME_NONNULL_BEGIN

/// Recommendation request.
@interface EMRecommendationRequest : NSObject

- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;

/// Initialize a new EMRecommendationRequest instance.
- (instancetype)initWithLogic:(NSString *)logic;
/// Exclude items where catalog field value is exactly the given value.
- (void)excludeItemsWhere:(NSString *)catalogField is:(NSString *)value;
/// Exclude items where catalog field value is contained in the given Array of
/// values.
- (void)excludeItemsWhere:(NSString *)catalogField
                     isIn:(NSArray<NSString *> *)array;
/// Exclude items where catalog field (a | separated list) contains the given
/// value.
- (void)excludeItemsWhere:(NSString *)catalogField has:(NSString *)value;
/// Exclude items where catalog field (a | separated list) overlaps with the
/// given Array of values.
- (void)excludeItemsWhere:(NSString *)catalogField
                 overlaps:(NSArray<NSString *> *)array;
/// Include items where catalog field value is exactly the given value.
- (void)includeItemsWhere:(NSString *)catalogField is:(NSString *)value;
/// Include items where catalog field value is contained in the given Array of
/// values.
- (void)includeItemsWhere:(NSString *)catalogField
                     isIn:(NSArray<NSString *> *)array;
/// Include items where catalog field (a | separated list) contains the given
/// value.
- (void)includeItemsWhere:(NSString *)catalogField has:(NSString *)value;
/// Include items where catalog field (a | separated list) overlaps with the
/// given Array of values.
- (void)includeItemsWhere:(NSString *)catalogField
                 overlaps:(NSArray<NSString *> *)array;

/// Recommendation logic.
@property(readonly) NSString *logic;
/// Number of items to recommend. Default: 5.
@property(readwrite) int limit;
/// The item IDs of the original recommendations. Only used when an A/B test is
/// in progress to compare the performance of the EmarsysMobile recommendations
/// vs. the
/// original (baseline) recommendations.
@property(readwrite, copy, nullable) NSArray<NSString *> *baseline;
/// Callback for the completion handling.
@property(readwrite, copy) void (^completionHandler)
    (EMRecommendationResult *completionHandler);

@end

NS_ASSUME_NONNULL_END
