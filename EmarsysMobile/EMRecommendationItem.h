//
//  EMRecommendationItem.h
//  EmarsysMobile
//

@import Foundation;

@class EMRecommendationResult;

#pragma mark - Result Item -

NS_ASSUME_NONNULL_BEGIN

/// Result item.
@interface EMRecommendationItem : NSObject

- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;

/// Item info.
@property(readonly) NSDictionary<NSString *, id> *data;
@end

NS_ASSUME_NONNULL_END
